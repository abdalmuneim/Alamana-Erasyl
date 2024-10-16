import 'package:alamanaelrasyl/core/resources/assets_manager.dart';
import 'package:alamanaelrasyl/core/widgets/custom_elevated_button.dart';
import 'package:alamanaelrasyl/features/auth/login/presentation/providers/login_provider.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(Assets.googleLogo),
            CustomButton(
              border: Border.all(),
              onPressed: () async {
                await authProvider.signIn();
              },
              child: Text(S.of(context).SignInwithGoogle),
            ),
          ],
        ),
      ),
    );
  }
}
