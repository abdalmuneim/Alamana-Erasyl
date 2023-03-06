import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sanad_abu_yousef/core/navigator/routes.dart';
import 'package:sanad_abu_yousef/core/resources/theme_manager.dart';
import 'package:sanad_abu_yousef/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: MaterialApp.router(
        title: 'علمنا الرسول',
        debugShowCheckedModeBanner: false,
        theme: applicationTheme,
        routerConfig: Routes.router,
      ),
    );
  }
}
