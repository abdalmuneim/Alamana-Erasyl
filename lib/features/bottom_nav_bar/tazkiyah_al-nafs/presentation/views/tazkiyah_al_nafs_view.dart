import 'package:alamanaelrasyl/core/resources/app_color.dart';
import 'package:alamanaelrasyl/core/utilities/extensions.dart';
import 'package:alamanaelrasyl/core/widgets/custom_elevated_button.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/tazkiyah_al-nafs/presentation/providers/tazkiyah_al_nafs_provider.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';
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
      body: watch.loggedin
          ? Center(
              child: Text(
                S.of(context).needLoginFirst,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                children: [
                  CustomButton(
                    border: Border.all(color: AppColors.mainApp),
                    margin:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 1.h),
                    height: 30,
                    color: AppColors.mainApp,
                    textColor: AppColors.scaffoldColor,
                    onPressed: () {},
                    text: S.of(context).createGrop,
                  ),
                ],
              ),
            ),
    );
  }
}
