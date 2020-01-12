import 'package:equatable/equatable.dart';

abstract class RecipeListEvent extends Equatable {
  @override
  List<Object> get props => [const []];
}

class RecipeListLoad extends RecipeListEvent {
  @override
  String toString() => "RecipeListLoad";
}
