import 'package:flutter/material.dart';
import 'package:alamanaerasyl/core/utilities/fields.dart';
import 'package:alamanaerasyl/core/handler/failure.dart';
import 'package:alamanaerasyl/core/utilities/utilities.dart';
import 'package:alamanaerasyl/core/services/network_info.dart';

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
