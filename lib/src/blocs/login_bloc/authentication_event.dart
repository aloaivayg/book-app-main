part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {}

class LoadingEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginEvent extends AuthenticationEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}
