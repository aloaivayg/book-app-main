import 'dart:async';
import 'package:flutter/material.dart';

abstract class Env {
  Env() {
    _init();
  }

  _init() async {
    final StatefulWidget app = FutureBuilder(
      future: await _onCreate(),
      builder: (context, snapshot) {
        return onCreateView();
      },
    );
    runApp(app);
  }

  Future? onInjection();

  FutureOr<void> onCreate();

  Widget onCreateView();

  Future? _onCreate() async {
    WidgetsFlutterBinding.ensureInitialized();

    await onInjection();
    await onCreate();
    runApp(onCreateView());
  }
}
