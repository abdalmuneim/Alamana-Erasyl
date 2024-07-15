import 'package:alamanaelrasyl/core/app_const/constant.dart';
import 'package:alamanaelrasyl/core/navigator/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:new_version/new_version.dart';

class NewerVersion {
  NewerVersion._init();
  static NewerVersion instance = NewerVersion._init();

  final BuildContext _context = NavigationService.context;

  initNewerVersion() async {
    NewVersion newVersion = NewVersion(
      iOSId: AppConstant.iosPackageName,
      androidId: AppConstant.androidPackageName,
    );

    _checkVersion(newVersion);
  }

  void _checkVersion(NewVersion newVersion) async {
    await newVersion.getVersionStatus().then((value) {
      newVersion.showUpdateDialog(
        context: _context,
        versionStatus: value!,
        dialogTitle: "UPDATE!!!",
        // dismissButtonText: "Skip",
        dialogText:
            "Please update the app from ${value.localVersion} to ${value.storeVersion}",
        dismissAction: () {
          SystemNavigator.pop();
        },
        updateButtonText: "Let's update",
      );
    });
  }
}
