import 'dart:collection';

import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/page/user/login/login.dart';
import 'package:book_app/src/page/user/sign_up/widgets/sign_up_field.dart';
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

typedef MenuEntry = DropdownMenuEntry<String>;

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
  final fieldController = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final fieldNames = <String>[
    "First Name",
    "Last Name",
    "Phone number",
    "Email",
    "Username",
    "Password",
    "Address"
  ];

  final List<String> countriesList = <String>['Viet Nam'];
  final List<String> provinceList = <String>[
    'Binh Duong',
    'Dong Nai',
    'Ho Chi Minh'
  ];
  final List<String> districtList = <String>[
    'Thu Dau Mot',
    'Thanh pho Moi',
    'Di An'
  ];
  final List<String> genderList = <String>['Male', 'Female', 'Other'];

  late String onCountrySelected;
  late String onProvinceSelected;
  late String onDistrictSelected;
  late String onGenderSelected;

  var signUpData = {
    "firstName": "",
    "lastName": "",
    "username": "",
    "password": "",
    "email": "",
    "phoneNumber": "",
    "country": "",
    "province": "",
    "district": "",
    "address": "",
    "gender": "",
  };

  final fieldInputType = <TextInputType>[
    TextInputType.text,
    TextInputType.text,
    TextInputType.number,
    TextInputType.emailAddress,
    TextInputType.text,
    TextInputType.visiblePassword,
    TextInputType.text,
  ];

  final fieldIcon = <Widget>[
    const FaIcon(
      FontAwesomeIcons.f,
      size: 20,
    ),
    const FaIcon(
      FontAwesomeIcons.l,
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
    const FaIcon(
      FontAwesomeIcons.addressCard,
      size: 20,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onCountrySelected = "";
    onProvinceSelected = "";
    onDistrictSelected = "";
    onGenderSelected = "";
    signUpData["country"] = countriesList.first;
    signUpData["province"] = provinceList.first;
    signUpData["district"] = districtList.first;
    signUpData["gender"] = genderList.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              height: Get.height * 0.02,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
            ),
            Container(
              // height: Get.height * 0.85,
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
                    Row(
                      children: [
                        Column(
                          children: [
                            _buildDropdownTitle("Country"),
                            Container(
                              width: Get.width * 0.45,
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex("#EA1E63"),
                                  borderRadius: BorderRadius.circular(8)),
                              child: _buildDropdownButton(countriesList,
                                  (selectedValue) {
                                setState(() {
                                  signUpData["country"] = selectedValue;
                                });
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          children: [
                            _buildDropdownTitle("Province"),
                            Container(
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex("#EA1E63"),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Get.width * 0.45,
                              child: _buildDropdownButton(provinceList,
                                  (selectedValue) {
                                setState(() {
                                  signUpData["province"] = selectedValue;
                                });
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            _buildDropdownTitle("District"),
                            Container(
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex("#EA1E63"),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Get.width * 0.45,
                              child: _buildDropdownButton(districtList,
                                  (selectedValue) {
                                setState(() {
                                  signUpData["district"] = selectedValue;
                                });
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          children: [
                            _buildDropdownTitle("Gender"),
                            Container(
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex("#EA1E63"),
                                  borderRadius: BorderRadius.circular(8)),
                              width: Get.width * 0.45,
                              child: _buildDropdownButton(genderList,
                                  (selectedValue) {
                                setState(() {
                                  signUpData["gender"] = selectedValue;
                                });
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        signUpData["firstName"] = fieldController[0].text;
                        signUpData["lastName"] = fieldController[1].text;
                        signUpData["phoneNumber"] = fieldController[2].text;
                        signUpData["email"] = fieldController[3].text;
                        signUpData["username"] = fieldController[4].text;
                        signUpData["password"] = fieldController[5].text;
                        signUpData["address"] = fieldController[6].text;

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
              margin: EdgeInsets.only(top: 30),
              height: Get.height * 0.15,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(child: const Text("ALREADY HAD ACCOUNT?")),
                  GestureDetector(
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                    child: Container(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: HexColor.fromHex("EA1E63"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
      listener: (context, state) {
        if (state is SignUpSuccess) {
          _openAnimatedDialog(context, "Register success");
        }
        if (state is SignUpError) {
          _openAnimatedDialog(context, state.message);
        }
      },
    );
  }

  Widget _buildDropdownButton(
      List<String> list, ValueChanged<String> onValueSelected) {
    final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
      list.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
    );

    return DropdownMenu<String>(
      width: Get.width * 0.45,
      initialSelection: list.first,
      onSelected: (String? value) {
        if (value != null) {
          setState(() {});
          onValueSelected(value);
        }
      },
      dropdownMenuEntries: menuEntries,
    );
  }

  Widget _buildDropdownTitle(String s) {
    return Container(
      width: Get.width * 0.45,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Text(s),
    );
  }

  void _openAnimatedDialog(BuildContext context, String message) {
    showGeneralDialog(
        context: context,
        pageBuilder: ((context, animation, secondaryAnimation) {
          return Container();
        }),
        transitionDuration: const Duration(milliseconds: 400),
        transitionBuilder: ((context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1).animate(animation),
              child: AlertDialog(
                title: Center(child: Text(message)),
                actions: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
