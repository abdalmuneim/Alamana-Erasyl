import 'package:alamanaerasyl/core/app_const/constant.dart';
import 'package:alamanaerasyl/core/navigator/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:new_version/new_version.dart';

class NewerVersion {
  NewerVersion._init();
  static NewerVersion instance = NewerVersion._init();

  final BuildContext _context = NavigationService.context;

  initNewerVersion() async {
    NewVersion newVersion = NewVersion(
      iOSId: Constant.iosPackageName,
      androidId: Constant.androidPackageName,
    );

    _checkVersion(newVersion);
  }

  void _checkVersion(NewVersion newVersion) async {
    VersionStatus? status = await newVersion.getVersionStatus();
    newVersion.showUpdateDialog(
      context: _context,
      versionStatus: status!,
      dialogTitle: "UPDATE!!!",
      // dismissButtonText: "Skip",
      dialogText:
          "Please update the app from ${status.localVersion} to ${status.storeVersion}",
      dismissAction: () {
        SystemNavigator.pop();
      },
      updateButtonText: "Let's update",
    );
  }
}
