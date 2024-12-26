import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/common/widgets/custom_appbar.dart';
import 'package:book_app/src/common/widgets/custom_bottom_navbar.dart';
import 'package:book_app/src/common/widgets/user_dialog.dart';
import 'package:book_app/src/page/home/home.dart';

import 'package:book_app/src/page/user/profile/edit_profile/edit_profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Profile"),
        body: UserProfileScreenDetails(),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}

class UserProfileScreenDetails extends StatefulWidget {
  const UserProfileScreenDetails({super.key});

  @override
  State<UserProfileScreenDetails> createState() =>
      _UserProfileScreenDetailsState();
}

class _UserProfileScreenDetailsState extends State<UserProfileScreenDetails> {
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      builder: (context, state) {
        return SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              Card(
                color: const Color.fromARGB(255, 41, 46, 48),
                child: ListTile(
                  leading: const FaIcon(FontAwesomeIcons.pen),
                  title: const Text('Edit profile'),
                  trailing: const FaIcon(FontAwesomeIcons.arrowRight),
                  onTap: () => Get.to(const EditProfileScreen()),
                ),
              ),
              const Card(
                color: Color.fromARGB(255, 41, 46, 48),
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.lock),
                  title: Text('Change password'),
                  trailing: FaIcon(FontAwesomeIcons.arrowRight),
                ),
              ),
              const Card(
                color: Color.fromARGB(255, 41, 46, 48),
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.addressCard),
                  title: Text('Change address'),
                  trailing: FaIcon(FontAwesomeIcons.arrowRight),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  openAnimatedDialog(context, "Do you want to logout?", () {
                    userBloc.add(const LogoutEvent());
                  });
                },
                child: const Card(
                  color: Color.fromARGB(255, 41, 46, 48),
                  child: ListTile(
                    leading: FaIcon(FontAwesomeIcons.rightFromBracket),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ),
              ),
              const Card(
                color: Color.fromARGB(255, 41, 46, 48),
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.deleteLeft),
                  title: Text(
                    'Delete account',
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              )
            ],
          ),
        ));
      },
      listener: (context, state) {
        if (state is LogoutSuccess) {
          openAnimatedDialog(
              context, "You have logged out", () => Get.off(HomePage()));
        }
      },
    );
  }
}
