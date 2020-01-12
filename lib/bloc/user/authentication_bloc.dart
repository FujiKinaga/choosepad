import 'package:choosepad/bloc/user/authentication_event.dart';
import 'package:choosepad/bloc/user/authentication_state.dart';
import 'package:choosepad/repository/user/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(
      {@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository;

  @override
  AuthenticationState get initialState => AuthenticationInProgress();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _authenticationRepository.isSignedIn();
      if (isSignedIn) {
        final currentUser = await _authenticationRepository.getCurrentUser();
        yield AuthenticationSuccess(currentUser: currentUser);
      } else {
        yield AuthenticationFailure();
      }
    } catch (_) {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield AuthenticationSuccess(
        currentUser: await _authenticationRepository.getCurrentUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield AuthenticationFailure();
    _authenticationRepository.signOut();
  }
}
