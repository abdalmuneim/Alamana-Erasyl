import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/resources/app_color.dart';
import 'package:alamanaelrasyl/core/utilities/extensions.dart';
import 'package:alamanaelrasyl/core/widgets/custom_elevated_button.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/tazkiyah_al-nafs/presentation/providers/tazkiyah_al_nafs_provider.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TazkiyahAlNafsView extends StatefulWidget {
  const TazkiyahAlNafsView({super.key});

  @override
  State<TazkiyahAlNafsView> createState() => _TazkiyahAlNafsViewState();
}

class _TazkiyahAlNafsViewState extends State<TazkiyahAlNafsView> {
  late TazkiyahAlNafsProvider read = context.read<TazkiyahAlNafsProvider>();
  late TazkiyahAlNafsProvider watch = context.watch<TazkiyahAlNafsProvider>();
  @override
  void initState() {
    read.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).tazkiyahAlNafs),
      ),
      body: watch.loggedin
          ? Center(
              child: Text(
                S.of(context).needLoginFirst,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : SafeArea(
              child: watch.loggedin
                  ? ListView(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      children: const [],
                    )
                  : Center(
                      child: TextButton(
                      child: Text(S.of(context).login),
                      onPressed: () {
                        context.goNamed(RouteNameStrings.login);
                      },
                    )),
            ),
      floatingActionButton: watch.loggedin
          ? FloatingActionButton(
              backgroundColor: AppColors.mainApp,
              tooltip: S.of(context).createGrop,
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(RouteNameStrings.createGroup);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
