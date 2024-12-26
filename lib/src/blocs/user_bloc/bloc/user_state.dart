part of 'user_bloc.dart';

class UserState extends Equatable {
  final DioException? error;
  final User? user;
  const UserState({this.error, this.user});
  @override
  List<Object> get props => [];
}

class DataLoading extends UserState {
  const DataLoading();
}

class SignUpSuccess extends UserState {
  const SignUpSuccess() : super();
}

class SignUpError extends UserState {
  final String message;
  const SignUpError({required this.message}) : super();
}

class SignInSuccess extends UserState {
  const SignInSuccess() : super();
}

class SignInError extends UserState {
  final String message;

  const SignInError({required this.message}) : super();
}

class EditProfileSuccess extends UserState {
  const EditProfileSuccess() : super();
}

class EditProfileError extends UserState {
  final String message;

  const EditProfileError({required this.message}) : super();
}

class LogoutSuccess extends UserState {
  const LogoutSuccess() : super();
}

class CreateReviewSuccess extends UserState {
  const CreateReviewSuccess() : super();
}

class CreateReviewError extends UserState {
  final String message;

  const CreateReviewError({required this.message}) : super();
}

class GetReviewByProductIdSuccess extends UserState {
  final List<Review> reviewList;
  const GetReviewByProductIdSuccess({required this.reviewList}) : super();
}
