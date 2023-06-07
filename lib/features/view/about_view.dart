import 'package:flutter/material.dart';
import 'package:alamanaerasyl/core/utilities/extensions.dart';
import 'package:alamanaerasyl/core/resources/app_string.dart';
import 'package:alamanaerasyl/core/resources/assets_manager.dart';
import 'package:alamanaerasyl/features/bottom_nav_bar/home/presentations/widgets/card_info.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ادعمنا'),
          /* actions: [
            IconButton(
                onPressed: () async {
                  await PaymentServices.instance.payPalRequest(context);
                },
                icon: Icon(
                  Icons.paypal,
                  color: Colors.blue[900],
                  size: 30,
                ))
          ], */
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
