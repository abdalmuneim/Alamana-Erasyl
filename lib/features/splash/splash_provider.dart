import 'dart:async';
import 'dart:developer';

import 'package:alamanaelrasyl/core/navigator/navigator_utils.dart';
import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/services/firebase_collec.dart';
import 'package:alamanaelrasyl/core/services/network_info.dart';
import 'package:alamanaelrasyl/core/utilities/utilities.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/tazkiyah_al-nafs/data/data_sources/azkar_locale_data_source.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashProvider extends ChangeNotifier {
  final AzkarLocaleDataSource _azkarLocaleDataSource;
  final NetworkInfoImpl _networkInfoImpl = NetworkInfoImpl.instance;

  SplashProvider(this._azkarLocaleDataSource);

  Future<void> startTimer() async {
    _networkInfoImpl.initializeNetworkStream();
    // _getAzkarMassaa();
    // _getAzkarMorning();
    Timer(
      const Duration(seconds: 3),
      () async => await navigator(),
    );
  }

  navigator() {
    final context = NavigationService.context;
    context.goNamed(RouteNameStrings.bottomNavBar);
  }

  _getAzkarMorning() async {
    await _azkarLocaleDataSource.getAzkar("azkar_morning.json").then((e) async {
      log("azkarAlsobh: $e");
      await FirebaseCollec.instance.setAzkarAlsobh(e);
    }).catchError((error) {
      log("errorS: ${error.toString()}");
      Utils.showErrorToast(error.toString());
    });
  }

  _getAzkarMassaa() async {
    await _azkarLocaleDataSource.getAzkar("azkar_massaa.json").then((e) async {
      log("azkarAlmasaa: $e");
      await FirebaseCollec.instance.setAzkarAlMasaa(e);
    }).catchError((error) {
      log("errorM: ${error.toString()}");
      Utils.showErrorToast(error.toString());
    });
  }
}
