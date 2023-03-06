import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanad_abu_yousef/core/extensions.dart';
import 'package:sanad_abu_yousef/core/resources/app_string.dart';
import 'package:sanad_abu_yousef/core/resources/size_config.dart';
import 'package:sanad_abu_yousef/core/widgets/loading_widget.dart';
import 'package:sanad_abu_yousef/models/video_model.dart';
import 'package:sanad_abu_yousef/presentations/providers/videos_playlist_provider.dart';

import 'package:sanad_abu_yousef/presentations/view/video_view.dart';

class VideosPlaylistView extends StatefulWidget {
  const VideosPlaylistView(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.url,
      required this.itemCount})
      : super(key: key);
  final String id;
  final String title;
  final String description;
  final String url;
  final String itemCount;

  @override
  State<VideosPlaylistView> createState() => _VideosPlaylistViewState();
}

class _VideosPlaylistViewState extends State<VideosPlaylistView> {
  late final read = context.read<VideosPlaylistProvider>();
  late final watch = context.watch<VideosPlaylistProvider>();

  @override
  void initState() {
    read.loadMoreVideos(playlistId: widget.id);
    super.initState();
  }

  @override
  void dispose() {
    read.disposeList();
    super.dispose();
  }

  _buildHeadPlaylist() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
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
                image: NetworkImage(widget.url),
              ),
              Container(
                width: 60,
                height: SizeConfig.screenHeight * .09,
                // margin: EdgeInsets.only(right: 10, top: 10),
                decoration: BoxDecoration(
                  color: Colors.black45,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.itemCount,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    Icon(
                      Icons.playlist_play_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.0.SW,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${widget.itemCount} ${AppString.video}',
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
    );
  }

  _buildVideo(Video video, int index) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoView(video: video),
        ),
      ),
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
            Text('${index}. '),
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl ?? ""),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
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
          body: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!watch.isLoading &&
                    watch.videos?.length != int.parse(widget.itemCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  read.loadMoreVideos(playlistId: widget.id);
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 1 + watch.videos!.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildHeadPlaylist();
                  }
                  Video video = watch.videos![index - 1];
                  return Column(
                    children: [
                      watch.videos!.isNotEmpty
                          ? _buildVideo(video, index)
                          : LoadingWidget(),
                      index == watch.videos?.length
                          ? index != int.parse(widget.itemCount)
                              ? CircularProgressIndicator()
                              : 0.SH
                          : 0.SH
                    ],
                  );
                },
              ))),
    );
  }
}
