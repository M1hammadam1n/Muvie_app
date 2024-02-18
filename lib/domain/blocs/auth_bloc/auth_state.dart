part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthUnauthorizedState extends AuthState {}

class AuthAuthorizedState extends AuthState {}

class AuthFailureState extends AuthState {
  final Object error;

  AuthFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class AuthInProgressState extends AuthState {}

class AuthCheckStatusInProgressState extends AuthState {}
