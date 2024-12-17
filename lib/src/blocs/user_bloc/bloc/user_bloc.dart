import 'package:bloc/bloc.dart';
import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/model/user.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const DataLoading()) {
    on<SignUpEvent>(onSignUpEvent);
    on<SignInEvent>(onSignInEvent);
  }

  var isSignedIn = false;
  User? user;

  void onSignUpEvent(SignUpEvent event, Emitter<UserState> emit) async {
    // final dataState = await User.loadUserFromBundle();
    print(event.signupData);
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
