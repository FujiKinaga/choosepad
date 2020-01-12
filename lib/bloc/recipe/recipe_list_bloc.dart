import 'package:choosepad/bloc/recipe/recipe_list_event.dart';
import 'package:choosepad/repository/recipe/recipe_list_repository.dart';
import 'package:choosepad/bloc/recipe/recipe_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  final RecipeListRepository _recipeListRepository;

  RecipeListBloc({@required RecipeListRepository recipeListRepository})
      : assert(recipeListRepository != null),
        _recipeListRepository = recipeListRepository;

  @override
  RecipeListState get initialState => RecipeListEmpty();

  @override
  Stream<RecipeListState> mapEventToState(RecipeListEvent event) async* {
    if (event is RecipeListLoad) {
      yield* _mapRecipeListLoadToState();
    }
  }

  Stream<RecipeListState> _mapRecipeListLoadToState() async* {
    yield RecipeListInProgress();
    try {
      yield RecipeListSuccess(recipeList: _recipeListRepository.fetch());
    } catch (_) {
      yield RecipeListFailure(error: _);
    }
  }
}
