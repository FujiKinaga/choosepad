import 'package:choosepad/data/recipe_ogp.dart';
import 'package:choosepad/repository/recipe/recipe_list_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRecipeListRepository extends RecipeListRepository {

  final Firestore _firestore;

  FirestoreRecipeListRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Stream<List<RecipeOgp>> fetch() {
    return _firestore.collection("recipes").snapshots().map((snapshot) {
      return snapshot.documents.map((docs) {
        return RecipeOgp();
      }).toList();
    });
  }
}