part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends UserEvent {
  final Map<String, dynamic> signupData;
  const SignUpEvent({required this.signupData});
}

class SignInEvent extends UserEvent {
  final Map<String, dynamic> signinData;
  final ClothesState prevState;

  const SignInEvent({required this.signinData, required this.prevState});
}

class EditProfileEvent extends UserEvent {
  final Map<String, dynamic> formData;

  const EditProfileEvent({required this.formData});
}

class LogoutEvent extends UserEvent {
  const LogoutEvent();
}

class CreateReviewEvent extends UserEvent {
  final Map<String, dynamic> formData;

  const CreateReviewEvent({required this.formData});
}

class GetReviewByProductIdEvent extends UserEvent {
  final String productId;

  const GetReviewByProductIdEvent({required this.productId});
}
