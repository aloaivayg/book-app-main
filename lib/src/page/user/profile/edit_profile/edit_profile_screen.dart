import 'dart:convert';

import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/common/const/color.dart';
import 'package:book_app/src/common/widgets/custom_appbar.dart';
import 'package:book_app/src/common/widgets/custom_bottom_navbar.dart';
import 'package:book_app/src/util/color_from_hex.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Edit Profile"),
        body: EditProfileScreenDetails(),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}

class EditProfileScreenDetails extends StatefulWidget {
  const EditProfileScreenDetails({super.key});

  @override
  State<EditProfileScreenDetails> createState() =>
      _EditProfileScreenDetailsState();
}

class _EditProfileScreenDetailsState extends State<EditProfileScreenDetails> {
  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> formData = {
    "id": "676bef8e5d3bfc1d08a9ee63",
    "avatarUrl": "",
    "firstName": "",
    "lastName": "",
    "email": "",
    "phoneNumber": "",
    "gender": ""
  };

  final List<String> genders = ["Male", "Female", "Other"];

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? selectedGender;
  Uint8List? _selectedImage;

  // Focus nodes
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneNumberFocus = FocusNode();
  final FocusNode genderFocus = FocusNode();

  late UserBloc userBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBloc = context.read<UserBloc>();
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      setState(() {
        _selectedImage = fileBytes;
        final base64Image = base64Encode(_selectedImage!);
        formData["avatarUrl"] = base64Image;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      userBloc.add(EditProfileEvent(formData: formData));
      print("Form Submitted");
    } else {
      print("Validation failed");
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Avatar (Network Image)
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? MemoryImage(_selectedImage!)
                      : (formData["avatarUrl"].isNotEmpty
                          ? NetworkImage(formData["avatarUrl"]) as ImageProvider
                          : null),
                  child: _selectedImage == null && formData["avatarUrl"].isEmpty
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // First Name TextField
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: AppColor.blueBlack,
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: firstNameController,
                focusNode: firstNameFocus,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "First Name is required";
                  }
                  return null;
                },
                onSaved: (value) {
                  formData["firstName"] = value;
                },
              ),
            ),
            const SizedBox(height: 20),

            // Last Name TextField
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: AppColor.blueBlack,
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: lastNameController,
                focusNode: lastNameFocus,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Last Name is required";
                  }
                  return null;
                },
                onSaved: (value) {
                  formData["lastName"] = value;
                },
              ),
            ),
            const SizedBox(height: 20),

            // Email TextField
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: AppColor.blueBlack,
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: emailController,
                focusNode: emailFocus,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                onSaved: (value) {
                  formData["email"] = value;
                },
              ),
            ),
            const SizedBox(height: 20),

            // Phone Number TextField
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: AppColor.blueBlack,
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: phoneNumberController,
                focusNode: phoneNumberFocus,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone Number is required";
                  }
                  if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
                    return "Enter a valid phone number";
                  }
                  return null;
                },
                onSaved: (value) {
                  formData["phoneNumber"] = value;
                },
              ),
            ),
            const SizedBox(height: 20),

            // Gender Dropdown
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              color: AppColor.blueBlack,
              child: DropdownButtonFormField<String>(
                focusNode: genderFocus,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(),
                ),
                value: selectedGender,
                items: genders
                    .map((gender) =>
                        DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a gender";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                onSaved: (value) {
                  formData["gender"] = value ?? "";
                },
              ),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: _submitForm,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                color: AppColor.lightPink,
                child: Center(child: Text("Save change".toUpperCase())),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
