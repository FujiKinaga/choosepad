import 'package:choosepad/data/current_user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInProgress extends AuthenticationState {
  @override
  String toString() => "Uninitialized";
}

class AuthenticationSuccess extends AuthenticationState {
  final CurrentUser currentUser;

  AuthenticationSuccess({@required this.currentUser})
      : assert(currentUser != null);

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() => "AuthenticationSuccess";
}

class AuthenticationFailure extends AuthenticationState {
  @override
  String toString() => "AuthenticationFailure";
}
