import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';

class FatwasView extends StatefulWidget {
  const FatwasView({Key? key}) : super(key: key);

  @override
  State<FatwasView> createState() => _FatwasViewState();
}

class _FatwasViewState extends State<FatwasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).fatwas,
        ),
      ),
      body: Center(
        child: Text(
          S.of(context).fatwas,
        ),
      ),
    );
  }
}
