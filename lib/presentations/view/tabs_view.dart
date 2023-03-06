import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sanad_abu_yousef/core/navigator/navigator_utils.dart';
import 'package:sanad_abu_yousef/core/navigator/route_string.dart';
import 'package:sanad_abu_yousef/core/resources/app_string.dart';
import 'package:sanad_abu_yousef/core/resources/size_config.dart';
import 'package:sanad_abu_yousef/presentations/providers/all_videos_provider.dart';
import 'package:sanad_abu_yousef/presentations/providers/playlists_provider.dart';
import 'package:sanad_abu_yousef/presentations/providers/tabs_provider.dart';
import 'package:sanad_abu_yousef/presentations/view/all_videos_view.dart';
import 'package:sanad_abu_yousef/presentations/view/playlist/playlists_view.dart';

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
  late final read = context.watch<TabsProvider>();
  @override
  void initState() {
    readAllVideos.initChannel();
    readPlaylist.initPlaylist();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    read.listenToNetwork();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    read.dispose();
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
                      '${watchAllVideos.channel?.subscriberCount ?? ""} ${AppString.subscribers}',
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

              return context.pushNamed(RouteStrings.about);
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
    TabController controller =
        TabController(initialIndex: 0, length: 2, vsync: this);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange,
                  ),
                  controller: controller,
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 30),
                  tabs: [
                    Tab(
                      child: Text(
                        AppString.mainScreen,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Tab(
                      child: Text(
                        AppString.playlist,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: const [
                  AllVideosView(),
                  PlaylistsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
