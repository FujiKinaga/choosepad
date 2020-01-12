import 'package:choosepad/data/current_user.dart';
import 'package:choosepad/repository/user/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthenticationRepository extends AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthenticationRepository(
      {FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<CurrentUser> getCurrentUser() async {
    final currentUser = await _firebaseAuth.currentUser();
    return CurrentUser(
      currentUser.uid,
      currentUser.displayName,
      currentUser.photoUrl,
      currentUser.isAnonymous,
      currentUser.metadata.creationTime,
      currentUser.metadata.lastSignInTime,
    );
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  @override
  Future<void> signOut() =>
    Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
}
