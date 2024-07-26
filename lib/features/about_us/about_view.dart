import 'package:alamanaelrasyl/core/resources/app_string.dart';
import 'package:alamanaelrasyl/core/resources/assets_manager.dart';
import 'package:alamanaelrasyl/core/utilities/extensions.dart';
import 'package:alamanaelrasyl/features/about_us/widgets/card_info.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).aboutUs),
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
