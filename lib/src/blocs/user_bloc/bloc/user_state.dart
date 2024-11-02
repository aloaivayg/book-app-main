part of 'user_bloc.dart';

class UserState extends Equatable {
  final DioException? error;
  final User? user;
  const UserState({this.error, this.user});
  @override
  List<Object> get props => [user!, error!];
}

class DataLoading extends UserState {
  const DataLoading();
}

class SignUpSuccess extends UserState {
  const SignUpSuccess(User user) : super(user: user);
}

class SignUpError extends UserState {
  const SignUpError(DioException error) : super(error: error);
}

class SignInSuccess extends UserState {
  const SignInSuccess(User user) : super(user: user);
}

class SignInError extends UserState {
  const SignInError(DioException error) : super(error: error);
}
