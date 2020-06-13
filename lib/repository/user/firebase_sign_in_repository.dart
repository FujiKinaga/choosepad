import 'package:choosepad/repository/user/sign_in_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSignInRepository extends SignInRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseSignInRepository(
      {FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<void> signInAnonymously() async {
    await _firebaseAuth.signInAnonymously();
  }
}
