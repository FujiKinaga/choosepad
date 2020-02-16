import 'package:choosepad/constants.dart';
import 'package:choosepad/data/tag.dart';

class Recipe {
  final String recipeId;
  final Tag tag;

  Recipe(this.recipeId, this.tag);

  String getLink() {
    return videoPath + recipeId;
  }
}

Recipe _getDummyRecipe1() {
  return Recipe(
    "7454",
    getDummyTag(),
  );
}

Recipe _getDummyRecipe2() {
  return Recipe(
    "7453",
    getDummyTag(),
  );
}

Recipe _getDummyRecipe3() {
  return Recipe(
    "7352",
    getDummyTag(),
  );
}

List<Recipe> getDummyRecipeList() {
  return [
    _getDummyRecipe1(),
    _getDummyRecipe2(),
    _getDummyRecipe3(),
  ];
}
