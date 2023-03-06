import 'package:flutter/material.dart';
import 'package:sanad_abu_yousef/core/fields.dart';
import 'package:sanad_abu_yousef/core/handler/failure.dart';
import 'package:sanad_abu_yousef/core/utilities.dart';
import 'package:sanad_abu_yousef/services/network_info.dart';

class TabsProvider extends ChangeNotifier {
  final NetworkInfoImpl _networkInfoImpl = NetworkInfoImpl.instance;

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
