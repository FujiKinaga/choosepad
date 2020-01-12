import 'package:choosepad/data/current_user.dart';
import 'package:choosepad/repository/user/authentication_repository.dart';

class DummyAuthenticationRepository extends AuthenticationRepository {
  @override
  Future<CurrentUser> getCurrentUser() async =>
      Future.value(getDummyCurrentUser());

  @override
  Future<bool> isSignedIn() async => Future.value(true);

  @override
  Future<void> signOut() async => Future.value();
}
