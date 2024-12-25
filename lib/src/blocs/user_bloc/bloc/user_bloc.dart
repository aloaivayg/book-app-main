import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/config/data_source/ServerUrl.dart';
import 'package:book_app/src/config/http/http_client.dart';
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
  }

  var isSignedIn = false;
  User? user;

  void onEditProfileEvent(
      EditProfileEvent event, Emitter<UserState> emit) async {
    final String url = '${ServerUrl.userApi}/updateProfile';

    final body = event.formData;
    final response = await HttpClient.postRequest(url, params: body);

    dynamic data = json.decode(response.body);

    if (response.statusCode == 200) {
      user = User.fromJson(data);
      print(data);
    } else {}
  }

  void onSignUpEvent(SignUpEvent event, Emitter<UserState> emit) async {
    print(event.signupData);
    final String url = '${ServerUrl.userApi}/register';
    final body = event.signupData;
    final response = await HttpClient.postRequest(url, params: body);

    dynamic data = json.decode(response.body);

    if (response.statusCode == 200) {
      print(jsonEncode(data));
      user = User.fromJson(data);
      emit(SignUpSuccess());
    } else {
      emit(SignUpError(message: data["error"]));
    }
  }

  void onSignInEvent(SignInEvent event, Emitter<UserState> emit) async {
    final dataState = await User.loadUserFromBundle();

    if (event.prevState is ViewClothesInfoSuccess) {
      print(event.prevState.item!.name);
    }

    // print(event.signinData);
    if (event.signinData["username"] == "a" &&
        event.signinData["password"] == "a") {
      isSignedIn = true;
      user = dataState;
      print(event.prevState.clothesList);
      user!.cart = event.prevState.clothesList!;

      emit(SignInSuccess(dataState));
    } else {
      isSignedIn = false;

      emit(SignInError(DioException.badResponse(
          statusCode: 404,
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions()))));
    }
  }
}
