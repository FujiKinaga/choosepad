import 'dart:math';

import 'package:choosepad/constants.dart';
import 'package:choosepad/data/recipe.dart';
import 'package:choosepad/data/recipe_ogp.dart';
import 'package:choosepad/data/tag.dart';
import 'package:choosepad/repository/recipe/recipe_list_repository.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class RecipeListRepositoryImpl extends RecipeListRepository {
  var _random = new Random();

  @override
  Stream<List<RecipeOgp>> fetch() async* {
    var ogpList = List<RecipeOgp>();

    var currentRetryCount = 0;

    do {
      if (currentRetryCount > maxRetryCount) {
        yield throw 'may cross origin error';
      }
      var randomRecipe =
          new Recipe(_random.nextInt(randomMaxValue).toString(), getDummyTag());
      try {
        var recipeOgp = await convertToRecipeList(randomRecipe);
        ogpList.add(recipeOgp);
        yield ogpList;
      } catch (err) {
        currentRetryCount++;
        print('Caught error: $err');
      }
    } while (ogpList.length < showRecipeListSize);
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
