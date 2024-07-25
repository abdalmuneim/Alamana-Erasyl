import 'package:alamanaelrasyl/core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alamanaelrasyl/core/app_const/constant.dart';
import 'package:alamanaelrasyl/core/utilities/extensions.dart';
import 'package:alamanaelrasyl/core/resources/assets_manager.dart';
import 'package:alamanaelrasyl/core/resources/size_config.dart';
import 'package:alamanaelrasyl/features/splash/splash_provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<SplashProvider>().startTimer();
    initFCM();
    super.initState();
  }

  initFCM() async {
    // ignore: unused_local_variable
    final notif = NotificationServiceImpl();
    /*  notif.pushNotification(
      deviceTokens: [await notif.getFCMToken() ?? ""],
      body: "test body 2",
      title: "test title 2",
      data: {"other": "other data 2"},
    ); */
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              Assets.logo,
              width: 250,
              height: 250,
            ),
            20.sh,
            Text(
              AppConstant.appName,
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
    );
  }
}
