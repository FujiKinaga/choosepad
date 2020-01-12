import 'package:choosepad/data/recipe.dart';

abstract class RecipeListRepository {
  Stream<List<Recipe>> fetch();
}
