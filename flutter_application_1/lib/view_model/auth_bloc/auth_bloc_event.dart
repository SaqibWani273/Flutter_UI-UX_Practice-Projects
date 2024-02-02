part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent {}

class CheckAuthEvent extends AuthBlocEvent {}

class SignInEvent extends AuthBlocEvent {
  final String number;
  final String? otp;

  SignInEvent({required this.number, this.otp});
}

class SignOutEvent extends AuthBlocEvent {
  final String email;
  final String password;
  SignOutEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthBlocEvent {}
