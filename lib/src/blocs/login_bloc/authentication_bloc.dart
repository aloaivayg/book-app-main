import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import '../../enums/enum.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

// Try making a custom version of BLoC library
// Event - Bloc - State
class AuthenticationBloc {
  var state = LoginInitialState();
  static int counter = 0;
  // event controller
  final eventController = StreamController<AuthenticationEvent>();
  StreamSink get emitEvent => eventController.sink;
  // state controller
  final stateController = StreamController<AuthenticationState>();
  Stream get stateStream => stateController.stream;

  AuthenticationBloc() {
    mapEventToState();
  }

  void mapEventToState() {
    eventController.stream.listen((AuthenticationEvent event) {
      // if (event is LoginEvent) {
      //   _onLogin(event);
      // }
      switch (event.runtimeType) {
        case LoginEvent:
          _onLogin(event as LoginEvent);
          break;
      }

      // stateController.sink.add(state);
    });
  }

  void _onLogin(LoginEvent event) {
    print("-----Login attemp:$counter");
    if (counter > 2) {
      stateController.sink.add(ErrorState("Max limit reach"));
    } else {
      if (event.username == "a" && event.password == "1") {
        stateController.sink.add(AuthenticatedState());
      } else {
        stateController.sink.addError("Wrong user name or password");
        counter++;
      }
    }
  }

  void dispose() {
    stateController.close();
    eventController.close();
  }
}
