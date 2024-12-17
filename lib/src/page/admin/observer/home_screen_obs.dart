import 'package:flutter/material.dart';

class HomeScreenObserver extends NavigatorObserver {
  final VoidCallback onActive;

  HomeScreenObserver({required this.onActive});

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    onActive();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    onActive();
  }
}
