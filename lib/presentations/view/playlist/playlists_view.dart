import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sanad_abu_yousef/core/fields.dart';
import 'package:sanad_abu_yousef/core/navigator/navigator_utils.dart';
import 'package:sanad_abu_yousef/core/navigator/route_string.dart';
import 'package:sanad_abu_yousef/core/resources/size_config.dart';
import 'package:sanad_abu_yousef/core/widgets/loading_widget.dart';
import 'package:sanad_abu_yousef/models/playlist_model.dart';
import 'package:sanad_abu_yousef/presentations/providers/playlists_provider.dart';

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
        BuildContext _context = NavigationService.context;
        print(items.id);
        return _context.pushNamed(
          RouteStrings.videosPlaylist,
          queryParams: <String, String>{
            Fields.id: items.id ?? "",
            Fields.title: items.snippet?.title ?? "",
            Fields.description: items.snippet?.description ?? "",
            Fields.url: items.snippet?.thumbnails?.thumbnailsDefault?.url ?? "",
            Fields.itemCount: items.contentDetails?.itemCount.toString() ?? "",
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
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
                  margin: EdgeInsets.only(right: 10, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        items.contentDetails!.itemCount!.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      Icon(
                        Icons.playlist_play_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items.snippet?.title ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    items.snippet?.description ?? "",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
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
                : Text('لا يوجد بيانات')
            : LoadingWidget(),
      ),
    );
  }
}
