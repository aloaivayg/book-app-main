import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../blocs/login_bloc/authentication_bloc.dart';
import '../../../settings/settings_controller.dart';
import '../../home/home.dart';

class LoginForm extends StatefulWidget {
  final AuthenticationBloc bloc;

  const LoginForm({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formController = TextEditingController();
  final formController1 = TextEditingController();
  late SettingsController settingsController;

  late Stream stateStream;

  @override
  void initState() {
    super.initState();
    stateStream = widget.bloc.stateStream;
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 290,
      child: StreamBuilder(
          stream: stateStream,
          // initialData: LoginInitialState,
          builder: ((context, snapshot) {
            // if (snapshot.hasError) {
            //   return Container(
            //     child: Text("Something went wrong"),
            //   );
            // }
            switch (snapshot.data.runtimeType) {
              case AuthenticatedState:
                _onAuthenticated();
                break;
              case ErrorState:
                _onMaxAttemp(snapshot);
                return const Text(
                  "Please try again later",
                  style: TextStyle(color: Colors.red),
                );
            }
            print(snapshot.data.toString());
            return Column(
              children: [
                TextFormField(
                  controller: formController,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    labelText: "Username",
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 232, 239, 220)),
                    errorText: snapshot.hasError ? "" : null,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextFormField(
                  controller: formController1,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.password_rounded,
                      color: Colors.white,
                    ),
                    labelText: "Password",
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 238, 241, 230)),
                    errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: _onLoginButtonPressed,
                      child: const Text("Login")),
                ),
              ],
            );
          })),
    );
  }

  void _onAuthenticated() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => HomePage(
                  settingsController: null,
                ))),
      );
    });
  }

  void _onLoginButtonPressed() async {
    widget.bloc.emitEvent
        .add(LoginEvent(formController.text, formController1.text));
  }

  void _onMaxAttemp(AsyncSnapshot snapshot) {
    ErrorState error1 = snapshot.data;
    print(error1.error);
  }
}
