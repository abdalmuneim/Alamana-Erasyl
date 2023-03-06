import 'package:flutter/material.dart';
import 'package:sanad_abu_yousef/core/extensions.dart';
import 'package:sanad_abu_yousef/core/resources/app_string.dart';
import 'package:sanad_abu_yousef/core/resources/assets_manager.dart';
import 'package:sanad_abu_yousef/presentations/view/widgets/card_info.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Image.asset(
              Assets.logo,
              width: 250,
              height: 250,
            ),
            50.sh,
            BuildCardInfo(
                image: Assets.sanad,
                name: AppString.sanad,
                info: AppString.infSanad),
            50.sh,
            BuildCardInfo(
                image: Assets.mahmoud,
                name: AppString.mahmoud,
                info: AppString.infMahmoud),
          ],
        ),
      ),
    );
  }
}
