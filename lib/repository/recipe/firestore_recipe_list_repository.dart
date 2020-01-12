import 'package:choosepad/data/recipe.dart';
import 'package:choosepad/data/tag.dart';
import 'package:choosepad/repository/recipe/recipe_list_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRecipeListRepository extends RecipeListRepository {

  final Firestore _firestore;

  FirestoreRecipeListRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Stream<List<Recipe>> fetch() {
    return _firestore.collection("recipes").snapshots().map((snapshot) {
      return snapshot.documents.map((docs) {
        return Recipe(
          docs.documentID,
          Tag(
              docs.data["tagId"] ?? "",
              docs.data["label"] ?? ""),
          docs.data["title"] ?? "",
          docs.data["description"] ?? "",
          docs.data["image_url"] ?? "",
        );
      }).toList();
    });
  }
}