import 'package:choosepad/data/recipe.dart';
import 'package:choosepad/data/recipe_ogp.dart';
import 'package:choosepad/repository/recipe/recipe_list_repository.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;

class DummyRecipeListRepository extends RecipeListRepository {

  @override
  Stream<List<RecipeOgp>> fetch() async* {
    var recipeList = getDummyRecipeList();

    var ogpList = List<RecipeOgp>(recipeList.length);

    for (int i = 0; i < recipeList.length; i++) {
      var recipe = recipeList[i];
      convertToRecipeList(recipe).then((recipeOgp) {
        ogpList[i] = recipeOgp;
      });
    }

    yield* Stream.value(ogpList);
  }

  Future<RecipeOgp> convertToRecipeList(Recipe recipe) async {
    var client = http.Client();
    var response = await client.get(recipe.getLink());
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