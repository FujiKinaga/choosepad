import 'dart:math';

import 'package:choosepad/constants.dart';
import 'package:choosepad/data/recipe.dart';
import 'package:choosepad/data/recipe_ogp.dart';
import 'package:choosepad/data/tag.dart';
import 'package:choosepad/repository/recipe/recipe_list_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRecipeListRepositoryImpl extends RecipeListRepository {
  final Firestore _firestore;
  var _random = new Random();

  FirestoreRecipeListRepositoryImpl({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Stream<List<RecipeOgp>> fetch() async* {
    var ogpList = List<RecipeOgp>();
    var currentRetryCount = 0;

    do {
      if (currentRetryCount > maxRetryCount) {
        yield throw 'may limit error';
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
    var response =
        await _firestore.collection("recipes").document(recipe.recipeId).get();
    if (!response.exists) {
      return throw 'not found';
    }
    return convertToRecipe(response.data);
  }

  RecipeOgp convertToRecipe(Map<String, dynamic> els) {
    var ogp = RecipeOgp();
    ogp.url = els["url"].toString();
    ogp.title = els["title"].toString().replaceAll('| クックパッド料理動画', '');
    ogp.description = els["description"].toString();
    ogp.image = els["image"].toString();
    ogp.video = els["video"].toString();
    ogp.videoHeight = els["videoHeight"] as int;
    ogp.videoWidth = els["videoWidth"] as int;
    return ogp;
  }
}
