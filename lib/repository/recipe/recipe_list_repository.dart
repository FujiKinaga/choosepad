import 'package:choosepad/data/recipe_ogp.dart';

abstract class RecipeListRepository {
  Stream<List<RecipeOgp>> fetch();
}
