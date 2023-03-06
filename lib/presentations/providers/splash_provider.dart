import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad_abu_yousef/core/fields.dart';
import 'package:sanad_abu_yousef/core/handler/failure.dart';
import 'package:sanad_abu_yousef/core/navigator/navigator_utils.dart';
import 'package:sanad_abu_yousef/core/navigator/route_string.dart';
import 'package:sanad_abu_yousef/core/utilities.dart';
import 'package:sanad_abu_yousef/services/network_info.dart';

class SplashProvider extends ChangeNotifier {
  NetworkInfoImpl _networkInfoImpl = NetworkInfoImpl.instance;

  Future<void> startTimer() async {
    _networkInfoImpl.initializeNetworkStream();
    Timer(
      const Duration(seconds: 3),
      () async => await navigator(),
    );
  }

  navigator() {
    final context = NavigationService.context;
    context.goNamed(RouteStrings.tabs);
  }

  listenToNetwork() {
    _networkInfoImpl.listenToNetworkStream.onData((bool isConnected) {
      if (isConnected) {
        Utils.removeEnhancedDialog(dialogName: Fields.networkFailure);
      } else {
        Utils.handleFailures(const ConnectionFailure());
      }
    });
  }
}
