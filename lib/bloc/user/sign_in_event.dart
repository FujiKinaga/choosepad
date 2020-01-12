import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [const []];
}

class SignInAnonymouslyOnPressed extends SignInEvent {}