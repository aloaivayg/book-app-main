import 'package:book_app/src/blocs/app_setting_bloc/bloc/app_setting_bloc.dart';
import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/page/cart/cart.dart';
import 'package:book_app/src/page/home/home.dart';
import 'package:book_app/src/page/sign_up/sign_up.dart';
import 'package:book_app/src/page/sign_up/widgets/sign_up_field.dart';
import 'package:book_app/src/settings/settings_controller.dart';
import 'package:book_app/src/util/color_from_hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            child: const Text("Login")),
      ),
      body: const SingleChildScrollView(
          scrollDirection: Axis.vertical, child: LoginDetail()),
    );
  }
}

class LoginDetail extends StatefulWidget {
  const LoginDetail({Key? key}) : super(key: key);

  @override
  State<LoginDetail> createState() => _LoginDetailState();
}

class _LoginDetailState extends State<LoginDetail> {
  late SettingsController settingsController;

  var signInData = {"username": "", "password": ""};

  final fieldController = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
  ];

  final fieldNames = <String>["Username", "Password"];

  final fieldInputType = <TextInputType>[
    TextInputType.text,
    TextInputType.visiblePassword
  ];

  final fieldIcon = <Widget>[
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final userState = context.watch<UserBloc>().state;
        final clothesState = context.read<ClothesBloc>().state;

        if (userState is SignInSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<ClothesBloc>().add(const ViewCartEvent());

            Get.off(CartPage());
          });
          return Container();
        }

        return Column(
          children: [
            Container(
              height: Get.height * 0.15,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            ),
            Container(
              height: Get.height * 0.6,
              margin: const EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.center,
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
                        signInData = {
                          "username": fieldController[0].text,
                          "password": fieldController[1].text
                        };

                        context.read<UserBloc>().add(SignInEvent(
                            signinData: signInData, prevState: clothesState));
                      },
                      child: Container(
                        width: 150,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: HexColor.fromHex("9C28B1"),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text("Sign in"),
                      ),
                    ),
                  ]),
            ),
            Container(
              height: Get.height * 0.15,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(child: const Text("New user?")),
                  GestureDetector(
                    onTap: () {
                      Get.to(SignUpScreen());
                    },
                    child: Container(
                      child: const Text(
                        "Sign up here",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
