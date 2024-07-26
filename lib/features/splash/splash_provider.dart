import 'dart:async';

import 'package:alamanaelrasyl/core/navigator/navigator_utils.dart';
import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/services/network_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashProvider extends ChangeNotifier {
  final NetworkInfoImpl _networkInfoImpl = NetworkInfoImpl.instance;

  Future<void> startTimer() async {
    _networkInfoImpl.initializeNetworkStream();
    Timer(
      const Duration(seconds: 3),
      () async => await navigator(),
    );
  }

  navigator() {
    final context = NavigationService.context;
    context.goNamed(RouteStrings.bottomNavBar);
  }
}
