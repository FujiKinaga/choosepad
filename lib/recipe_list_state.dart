import 'package:choosepad/data/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RecipeListState extends Equatable {
  @override
  List<Object> get props => [const []];
}

class RecipeListEmpty extends RecipeListState {
  @override
  String toString() => "RecipeListEmpty";
}

class RecipeListInProgress extends RecipeListState {
  @override
  String toString() => "RecipeListInProgress";
}

class RecipeListSuccess extends RecipeListState {
  final Stream<List<Recipe>> recipeList;

  RecipeListSuccess({@required this.recipeList}) : assert(recipeList != null);

  @override
  List<Object> get props => [recipeList];

  @override
  String toString() => "RecipeListSuccess";
}

class RecipeListFailure extends RecipeListState {
  final Error error;

  RecipeListFailure({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => "RecipeListFailure";
}
