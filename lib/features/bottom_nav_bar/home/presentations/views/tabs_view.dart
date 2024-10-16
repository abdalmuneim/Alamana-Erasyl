import 'package:alamanaelrasyl/core/navigator/navigator_utils.dart';
import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/resources/app_color.dart';
import 'package:alamanaelrasyl/core/resources/size_config.dart';
import 'package:alamanaelrasyl/core/services/get_device_id.dart';
import 'package:alamanaelrasyl/features/about_us/about_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/all_videos_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/playlists_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/tabs_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/all_videos_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/playlist/playlists_view.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class TabsView extends StatefulWidget {
  const TabsView({Key? key}) : super(key: key);

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> with TickerProviderStateMixin {
  late final readPlaylist = context.read<PlaylistsProvider>();
  late final watchPlaylist = context.watch<PlaylistsProvider>();
  late final readAllVideos = context.read<AllVideosProvider>();
  late final watchAllVideos = context.watch<AllVideosProvider>();
  late final watchTap = context.watch<TabsProvider>();
  late final readTap = context.read<TabsProvider>();
  @override
  void initState() {
    readAllVideos.initChannel();
    readPlaylist.initPlaylist();
    readTap.setTabController(this);
    super.initState();
  }

  @override
  void dispose() {
    readTap.dispose();
    watchTap.dispose();
    readPlaylist.dispose();
    watchPlaylist.dispose();
    readAllVideos.dispose();
    watchAllVideos.dispose();
    super.dispose();
  }

  _buildProfileInfo() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              watchAllVideos.channel?.profilePictureUrl != null
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      backgroundImage: NetworkImage(
                          watchAllVideos.channel?.profilePictureUrl ?? ""),
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      watchAllVideos.channel?.title ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      watchAllVideos.channel?.description ?? "",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${watchAllVideos.channel?.subscriberCount ?? ""} ${S.of(context).subscribe}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: IconButton(
            onPressed: () {
              BuildContext context = NavigationService.context;
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                settings: RouteSettings(name: RouteNameStrings.aboutUs),
                screen: const AboutUsView(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
              // return context.pushNamed(RouteStrings.about);
            },
            icon: const Icon(
              Icons.info_outline,
              size: 30,
              color: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    GetDeviceId.instance.getDeviceId().then((value) => print("value: $value"));

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer(builder: (context, TabsProvider tapPro, child) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight / 30),
              _buildProfileInfo(),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TabBar(
                    physics: const NeverScrollableScrollPhysics(),
                    onTap: (value) => tapPro.setCurrentIndex(value),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.mainApp,
                    ),
                    controller: tapPro.tabController,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 30),
                    tabs: [
                      Tab(
                        child: Text(
                          S.of(context).main,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: tapPro.currentIndex == 0
                                        ? Colors.white
                                        : AppColors.mainApp,
                                  ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          S.of(context).playLists,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: tapPro.currentIndex == 1
                                        ? Colors.white
                                        : AppColors.mainApp,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tapPro.tabController,
                  children: const [
                    AllVideosView(),
                    PlaylistsView(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
