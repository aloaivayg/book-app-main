import 'package:book_app/src/common/widgets/custom_appbar.dart';
import 'package:book_app/src/common/widgets/custom_bottom_navbar.dart';
import 'package:book_app/src/page/user/profile/edit_profile/edit_profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: Column(
        children: [
          Card(
            color: Color.fromARGB(255, 41, 46, 48),
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.pen),
              title: Text('Edit profile'),
              trailing: FaIcon(FontAwesomeIcons.arrowRight),
              onTap: () => Get.to(EditProfileScreen()),
            ),
          ),
          Card(
            color: Color.fromARGB(255, 41, 46, 48),
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.lock),
              title: Text('Change password'),
              trailing: FaIcon(FontAwesomeIcons.arrowRight),
            ),
          ),
          Card(
            color: Color.fromARGB(255, 41, 46, 48),
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.addressCard),
              title: Text('Change address'),
              trailing: FaIcon(FontAwesomeIcons.arrowRight),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            color: Color.fromARGB(255, 41, 46, 48),
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.rightFromBracket),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ),
          Card(
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
  }
}
