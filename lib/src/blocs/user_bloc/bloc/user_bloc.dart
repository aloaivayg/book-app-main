import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/config/data_source/ServerUrl.dart';
import 'package:book_app/src/config/http/http_client.dart';
import 'package:book_app/src/model/review.dart';
import 'package:book_app/src/model/user.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const DataLoading()) {
    on<SignUpEvent>(onSignUpEvent);
    on<SignInEvent>(onSignInEvent);
    on<EditProfileEvent>(onEditProfileEvent);
    on<LogoutEvent>(onLogoutEvent);
    on<CreateReviewEvent>(onCreateReviewEvent);
    on<GetReviewByProductIdEvent>(onGetReviewByProductIdEvent);
  }

  var isSignedIn = false;
  User? user;

  void onGetReviewByProductIdEvent(
      GetReviewByProductIdEvent event, Emitter<UserState> emit) async {
    final String url =
        '${ServerUrl.reviewApi}/getAllByProductId/${event.productId}';

    final response = await HttpClient.getRequest(url);
    dynamic data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Review> reviewList =
          data.map((json) => Review.fromJson(json)).toList().cast<Review>();

      emit(DataLoading());

      emit(GetReviewByProductIdSuccess(reviewList: reviewList));
    } else {}
  }

  void onCreateReviewEvent(
      CreateReviewEvent event, Emitter<UserState> emit) async {
    final String url = '${ServerUrl.reviewApi}/create';

    final body = event.formData;
    final response = await HttpClient.postRequest(url, params: body);
    dynamic data = json.decode(response.body);

    if (response.statusCode == 200) {
      Review review = Review.fromJson(data);

      emit(DataLoading());

      emit(CreateReviewSuccess());
    } else {
      emit(CreateReviewError(message: "error"));
    }
  }

  void onLogoutEvent(LogoutEvent event, Emitter<UserState> emit) async {
    user = null;

    emit(DataLoading());
    emit(LogoutSuccess());
  }

  void onEditProfileEvent(
      EditProfileEvent event, Emitter<UserState> emit) async {
    final String url = '${ServerUrl.userApi}/updateProfile';

    final body = event.formData;
    final response = await HttpClient.postRequest(url, params: body);
    dynamic data = json.decode(response.body);

    if (response.statusCode == 200) {
      user = User.fromJson(data);

      emit(EditProfileSuccess());
    } else {
      emit(EditProfileError(message: data["message"]));
    }
  }

  void onSignUpEvent(SignUpEvent event, Emitter<UserState> emit) async {
    final String url = '${ServerUrl.userApi}/register';
    final body = event.signupData;
    final response = await HttpClient.postRequest(url, params: body);

    dynamic data = json.decode(response.body);

    if (response.statusCode == 200) {
      user = User.fromJson(data);
      emit(SignUpSuccess());
    } else {
      emit(SignUpError(message: data["error"]));
    }
  }

  // LOGIN
  void onSignInEvent(SignInEvent event, Emitter<UserState> emit) async {
    print(event.signinData);
    final String url = '${ServerUrl.userApi}/login';
    final body = event.signinData;
    final response = await HttpClient.postRequest(url, params: body);

    Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      isSignedIn = true;

      user = User.fromJson(data);

      emit(const SignInSuccess());
    } else {
      isSignedIn = false;
      emit(DataLoading());
      emit(SignInError(message: data["message"]));
    }
  }
}
