import 'package:choosepad/bloc/user/sign_in_event.dart';
import 'package:choosepad/bloc/user/sign_in_state.dart';
import 'package:choosepad/repository/user/sign_in_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepository _signInRepository;

  SignInBloc({@required SignInRepository signInRepository})
      : assert(signInRepository != null),
        _signInRepository = signInRepository;

  @override
  SignInState get initialState => SignInEmpty();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInAnonymouslyOnPressed) {
      yield* _mapSignInAnonymouslyOnPressed();
    }
  }

  Stream<SignInState> _mapSignInAnonymouslyOnPressed() async* {
    yield SignInLoading();
    try {
      await _signInRepository.signInAnonymously();
      yield SignInSuccess();
    } catch (_) {
      yield SignInFailure();
    }
  }
}
