import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanad_abu_yousef/core/constant.dart';
import 'package:sanad_abu_yousef/core/extensions.dart';
import 'package:sanad_abu_yousef/core/resources/assets_manager.dart';
import 'package:sanad_abu_yousef/core/resources/size_config.dart';
import 'package:sanad_abu_yousef/presentations/providers/splash_provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<SplashProvider>().startTimer();
    super.initState();
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
              Constant.appName,
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
    );
  }
}
