import 'package:choosepad/data/recipe.dart';
import 'package:choosepad/data/recipe_ogp.dart';
import 'package:choosepad/data/tag.dart';
import 'package:choosepad/repository/recipe/recipe_list_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class FirestoreRecipeListRepositoryImpl extends RecipeListRepository {
  final Firestore _firestore;

  FirestoreRecipeListRepositoryImpl({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Stream<List<RecipeOgp>> fetch() async* {
    var ogpList = List<RecipeOgp>();

    // 現在1000
    var currentRecipeId = 1000;
    var idMaxCount = 2000;

    do {
      currentRecipeId++;
      var randomRecipe = new Recipe(currentRecipeId.toString(), getDummyTag());
      try {
        var recipeOgp = await convertToRecipeList(randomRecipe);
        await _firestore
            .collection('recipes')
            .document(currentRecipeId.toString())
            .setData({
          'id': currentRecipeId.toString(),
          'title': recipeOgp.title,
          'description': recipeOgp.description,
          'image': recipeOgp.image,
          'url': recipeOgp.url,
          'video': recipeOgp.video,
          'videoHeight': recipeOgp.videoHeight,
          'videoWidth': recipeOgp.videoWidth
        });
        yield ogpList;
      } catch (err) {
        print('Caught error: $err');
      }
    } while (currentRecipeId < idMaxCount);
  }

  Future<RecipeOgp> convertToRecipeList(Recipe recipe) async {
    var client = http.Client();
    var response = await client.get(recipe.getLink());
    if (response.statusCode != 200) {
      return throw 'not found';
    }
    var document = parse(response.body);
    return convertToRecipe(document.head.getElementsByClassName("pjax_target"));
  }

  RecipeOgp convertToRecipe(List<Element> headEls) {
    var ogp = RecipeOgp();

    for (int i = 0; i < headEls.length; i++) {
      var element = headEls[i];
      var property = element.attributes["property"];
      var content = element.attributes["content"];
      switch (property) {
        case "og:url":
          ogp.url = content;
          break;
        case "og:title":
          ogp.title = content;
          break;
        case "og:description":
          ogp.description = content;
          break;
        case "og:image":
          ogp.image = content;
          break;
        case "og:video":
          ogp.video = content;
          break;
        case "og:video:height":
          ogp.videoHeight = int.parse(content);
          break;
        case "og:video:width":
          ogp.videoWidth = int.parse(content);
          break;
      }
    }
    return ogp;
  }
}
