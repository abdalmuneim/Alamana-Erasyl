import 'package:alamanaelrasyl/firebase_options.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:alamanaelrasyl/core/navigator/routes.dart';
import 'package:alamanaelrasyl/core/resources/theme_manager.dart';
import 'package:alamanaelrasyl/providers.dart';
import 'package:sizer/sizer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async =>
    debugPrint("Message id: ${message.messageId}");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setAutoInitEnabled(true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,orientation, deviceType) {
        return MultiProvider(
          providers: Providers.providers,
          child: MaterialApp.router(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: const Locale("ar"),
            supportedLocales: S.delegate.supportedLocales,
            // title: S.of(context).alamnaAlrasol,
            debugShowCheckedModeBanner: false,
            theme: applicationTheme,
            routerConfig: Routes.router,
          ),
        );
      }
    );
  }
}
