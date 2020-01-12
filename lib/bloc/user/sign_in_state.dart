import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [const []];
}

class SignInEmpty extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {}
