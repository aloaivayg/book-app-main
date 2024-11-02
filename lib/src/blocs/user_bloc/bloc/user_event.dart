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
