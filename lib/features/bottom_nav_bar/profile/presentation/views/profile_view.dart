import 'package:alamanaelrasyl/core/resources/app_color.dart';
import 'package:alamanaelrasyl/core/utilities/extensions.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/profile/presentation/providers/profile_provider.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileProvider read = context.read<ProfileProvider>();
  late ProfileProvider watch = context.watch<ProfileProvider>();

  @override
  void initState() {
    read.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).myProfile),
      ),
      body: !watch.loggedin
          ? Center(
              child: Text(
                S.of(context).needLoginFirst,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              children: [
                2.h.sh,
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.mainApp,
                          image: DecorationImage(
                            image: NetworkImage(
                              watch.user?.photoURL ?? "",
                            ),
                          ),
                        ),
                      ),
                      1.h.sh,
                      Text(
                        watch.user?.displayName ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                2.h.sh,
                Text(
                  S.of(context).email,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                1.h.sh,
                Text(
                  watch.user?.email ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                2.h.sh,
                Text(
                  S.of(context).phone,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                1.h.sh,
                Text(
                  watch.user?.phoneNumber ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                2.h.sh,
              ],
            ),
    );
  }
}
