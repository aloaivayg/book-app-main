import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class AppBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    // init service, controller, repo, etc
    debugPrint("------------BINDING NECCESSARY CONTROLLERS-----------");
  }

  Future<void> requestPermission() async {}

  Future<String> getDeviceInfo() async {
    return "";
  }
}
