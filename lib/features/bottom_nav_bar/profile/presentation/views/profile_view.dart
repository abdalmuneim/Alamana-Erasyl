import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/resources/app_color.dart';
import 'package:alamanaelrasyl/core/utilities/extensions.dart';
import 'package:alamanaelrasyl/core/widgets/custom_cache_image.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/profile/presentation/providers/profile_provider.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      body: watch.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : !watch.loggedIn
              ? Center(
                  child: TextButton(
                    child: Text(
                      S.of(context).login,
                    ),
                    onPressed: () => context.goNamed(RouteNameStrings.login),
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
                          CustomCacheNetwork(
                            url: (watch.user?.image != null ||
                                    watch.user?.image != "")
                                ? watch.user?.image ?? ""
                                : "",
                            color: AppColors.mainApp,
                            width: 30.w,
                            height: 30.w,
                            isCircle: true,
                          ),
                          1.h.sh,
                          Text(
                            watch.user?.name ?? "",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    2.h.sh,
                    Text(
                      S.of(context).email,
                    ),
                    1.h.sh,
                    Text(
                      watch.user?.email ?? "",
                    ),
                    if (watch.user?.phone != null) ...[
                      2.h.sh,
                      Text(
                        S.of(context).phone,
                      ),
                      1.h.sh,
                      Text(
                        watch.user?.phone ?? "",
                      ),
                    ],
                    if (watch.user?.address != null) ...[
                      2.h.sh,
                      Text(
                        S.of(context).address,
                      ),
                      1.h.sh,
                      Text(
                        watch.user?.address ?? "",
                      ),
                    ], if (watch.user?.bio != null) ...[
                      2.h.sh,
                      Text(
                        S.of(context).bio,
                      ),
                      1.h.sh,
                      Text(
                        watch.user?.bio ?? "",
                      ),
                    ],
                  ],
                ),
    );
  }
}
