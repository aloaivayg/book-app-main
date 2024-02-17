part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class LoginInitialState extends AuthenticationState {
  final AuthenticationStatus status;
  LoginInitialState({this.status = AuthenticationStatus.unknown});

  @override
  List<Object?> get props => [status];
}

class AuthenticatedState extends AuthenticationState {
  final AuthenticationStatus status = AuthenticationStatus.authenticated;

  @override
  List<Object?> get props => [status];
}

class ErrorState extends AuthenticatedState {
  final String error;

  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
