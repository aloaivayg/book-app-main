import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/page/user/login.dart';
import 'package:book_app/src/page/sign_up/widgets/sign_up_field.dart';
import 'package:book_app/src/util/color_from_hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: const Color.fromARGB(255, 254, 252, 252),
            onPressed: () {
              context.read<ClothesBloc>().add(const ViewCartEvent());
              Get.back();
            },
          ),
        ),
        actions: const [
          SizedBox(
            width: 40,
          )
        ],
        title: Container(
            alignment: Alignment.center,
            width: Get.width,
            child: const Text("Sign up")),
      ),
      body: const SingleChildScrollView(
          scrollDirection: Axis.vertical, child: SignUpScreenDetail()),
    );
  }
}

class SignUpScreenDetail extends StatefulWidget {
  const SignUpScreenDetail({Key? key}) : super(key: key);

  @override
  State<SignUpScreenDetail> createState() => _SignUpScreenDetailState();
}

class _SignUpScreenDetailState extends State<SignUpScreenDetail> {
  var signUpData = {
    "name": "",
    "phone": "",
    "email": "",
    "username": "",
    "password": ""
  };

  final fieldController = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final fieldNames = <String>[
    "Name",
    "Phone number",
    "Email",
    "Username",
    "Password"
  ];

  final fieldInputType = <TextInputType>[
    TextInputType.text,
    TextInputType.number,
    TextInputType.emailAddress,
    TextInputType.text,
    TextInputType.visiblePassword
  ];

  final fieldIcon = <Widget>[
    const FaIcon(
      FontAwesomeIcons.a,
      size: 20,
    ),
    const FaIcon(
      FontAwesomeIcons.phone,
      size: 20,
    ),
    const Icon(
      Icons.mail,
      size: 20,
    ),
    const Icon(
      Icons.person,
      size: 20,
    ),
    const FaIcon(
      FontAwesomeIcons.lock,
      size: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              height: Get.height * 0.15,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            ),
            Container(
              height: Get.height * 0.6,
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: SignUpField(
                              controller: fieldController[index],
                              keyboardType: fieldInputType[index],
                              icon: fieldIcon[index],
                              text: fieldNames[index],
                            ));
                      },
                      itemCount: fieldNames.length,
                    ),
                    GestureDetector(
                      onTap: () {
                        signUpData = {
                          "name": fieldController[0].text,
                          "phone": fieldController[1].text,
                          "email": fieldController[2].text,
                          "username": fieldController[3].text,
                          "password": fieldController[4].text
                        };

                        context
                            .read<UserBloc>()
                            .add(SignUpEvent(signupData: signUpData));
                      },
                      child: Container(
                        width: 150,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: HexColor.fromHex("9C28B1"),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text("Confirm"),
                      ),
                    ),
                  ]),
            ),
            Container(
              height: Get.height * 0.15,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(child: const Text("ALREADY HAD ACCOUNT?")),
                  GestureDetector(
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                    child: Container(
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
