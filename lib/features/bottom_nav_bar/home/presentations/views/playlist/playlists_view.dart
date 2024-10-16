import 'package:alamanaelrasyl/core/navigator/navigator_utils.dart';
import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/resources/size_config.dart';
import 'package:alamanaelrasyl/core/widgets/loading_widget.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/data/models/playlist_model.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/playlists_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/playlist/videos_playlist_view.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class PlaylistsView extends StatefulWidget {
  const PlaylistsView({Key? key}) : super(key: key);

  @override
  State<PlaylistsView> createState() => _PlaylistsViewState();
}

class _PlaylistsViewState extends State<PlaylistsView> {
  late PlaylistsProvider read = context.read<PlaylistsProvider>();
  late PlaylistsProvider watch = context.watch<PlaylistsProvider>();

  _buildPlayList(ItemPlaylist items) {
    return GestureDetector(
      onTap: () {
        BuildContext context = NavigationService.context;
        PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
          context,
          settings: RouteSettings(
            name: RouteNameStrings.videosPlaylist,
          ),
          screen: VideosPlaylistView(
            id: items.id ?? "",
            title: items.snippet?.title ?? "",
            description: items.snippet?.description ?? "",
            url: items.snippet?.thumbnails?.thumbnailsDefault?.url ?? "",
            itemCount: items.contentDetails?.itemCount.toString() ?? "",
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        height: 140.0,
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
            Stack(
              children: [
                Image(
                  image: NetworkImage(
                      items.snippet?.thumbnails?.thumbnailsDefault?.url ?? ""),
                  width: 140,
                ),
                Container(
                  width: 60,
                  height: SizeConfig.screenHeight * .09,
                  margin: const EdgeInsets.only(right: 10, top: 10),
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        items.contentDetails!.itemCount!.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const Icon(
                        Icons.playlist_play_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items.snippet?.title ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    items.snippet?.description ?? "",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: !watch.isLoading
            ? watch.playlists != null
                ? ListView.builder(
                    itemCount: watch.playlists!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ItemPlaylist item = watch.playlists![index];
                      return _buildPlayList(item);
                    },
                  )
                : Text(S.of(context).notHavePlayLists)
            : const LoadingWidget(),
      ),
    );
  }
}
