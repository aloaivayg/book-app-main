import 'package:book_app/src/page/login/widgets/login_form.dart';
import 'package:book_app/src/page/login/widgets/login_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../blocs/login_bloc/authentication_bloc.dart';
import '../../settings/settings_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var bloc = AuthenticationBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/login_bg.png",
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Center(
                child: LoginForm(
          bloc: bloc,
        )
                //             Container(
                //   color: Colors.red,
                //   height: 400,
                //   width: 500,
                // )
                )),
        const RotatingWidget(),
      ]),
    );
  }
}
