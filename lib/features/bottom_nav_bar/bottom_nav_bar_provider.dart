import 'package:alamanaelrasyl/core/handler/failure.dart';
import 'package:alamanaelrasyl/core/services/network_info.dart';
import 'package:alamanaelrasyl/core/utilities/fields.dart';
import 'package:alamanaelrasyl/core/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int selectedIndex = 0;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
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
