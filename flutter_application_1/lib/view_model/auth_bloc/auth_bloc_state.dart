part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState {}

class UnAuthenticatedState extends AuthBlocState {}

class OtpSentState extends AuthBlocState {}

class AuthenticatedState extends AuthBlocState {}

class AuthErrorState extends AuthBlocState {
  final String errMsg;
  AuthErrorState({required this.errMsg});
}

class LoadingState extends AuthBlocState {}
