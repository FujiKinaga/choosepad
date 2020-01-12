import 'package:choosepad/data/recipe.dart';
import 'package:choosepad/repository/recipe_list_repository.dart';

class DummyRecipeListRepository extends RecipeListRepository {
  @override
  Stream<List<Recipe>> fetch() {
    return Stream.value(getDummyRecipeList());
  }
}