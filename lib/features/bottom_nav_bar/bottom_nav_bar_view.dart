import 'package:alamanaelrasyl/core/resources/app_color.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/bottom_nav_bar_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/view/fatwas_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/tabs_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/profile/presentation/views/profile_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/tazkiyah_al-nafs/presentation/views/tazkiyah_al_nafs_view.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  @override
  void didChangeDependencies() {
    // NewerVersion.instance.initNewerVersion();
    context.read<BottomNavBarProvider>().listenToNetwork();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // BottomNavBarProvider read = context.read<BottomNavBarProvider>();
    BottomNavBarProvider watch = context.watch<BottomNavBarProvider>();
    return PersistentTabView(
      context,
      controller: watch.controller,
      screens: const [
        ProfileView(),
        TabsView(),
        FatwasView(),
        TazkiyahAlNafsView(),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_3_outlined),
          title: S.of(context).account,
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: AppColors.notActive,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.video_collection_outlined),
          title: (S.of(context).main),
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: AppColors.notActive,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.question_diamond),
          title: (S.of(context).fatwas),
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: AppColors.notActive,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.person_2_square_stack),
          title: S.of(context).tazkiyah,
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: AppColors.notActive,
        ),
      ],
      confineToSafeArea: true,
      backgroundColor: CupertinoColors.activeGreen, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      // hideNavigationBarWhenKeyboardShows:
      //     true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      //
      // popAllScreensOnTapOfSelectedTab: true,
      // popActionScreens: PopActionScreensType.all,
      // itemAnimationProperties: const ItemAnimationProperties(
      // Navigation Bar's items animation properties.
      // duration: Duration(milliseconds: 300),
      // curve: Curves.ease,
      // ),
      // screenTransitionAnimation: const ScreenTransitionAnimation(
      // Screen transition animation on change of selected tab.
      // animateTabTransition: true,
      // curve: Curves.ease,
      // duration: Duration(milliseconds: 300),
      // ),
      navBarStyle:
          NavBarStyle.style14, // Choose the nav bar style with this property.
    );
  }
}
