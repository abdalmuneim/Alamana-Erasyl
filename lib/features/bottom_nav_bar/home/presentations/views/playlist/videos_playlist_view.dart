import 'package:alamanaelrasyl/core/resources/size_config.dart';
import 'package:alamanaelrasyl/core/utilities/extensions.dart';
import 'package:alamanaelrasyl/core/widgets/loading_widget.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/data/models/video_model.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/videos_playlist_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/widgets/card_video.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
    read.loadMoreVideos(
      playlistId: widget.id,
      numLoad: int.parse(widget.itemCount) >= 8 ? "8" : widget.itemCount,
    );
    super.initState();
  }

  @override
  void dispose() {
    read.disposeList();
    super.dispose();
  }

  _buildHeadPlaylist() {
    return Container(
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
          Stack(
            children: [
              Image(
                image: NetworkImage(widget.url),
              ),
              Container(
                width: 60,
                height: SizeConfig.screenHeight * .09,
                // margin: EdgeInsets.only(right: 10, top: 10),
                decoration: const BoxDecoration(
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
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const Icon(
                      Icons.playlist_play_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.0.sw,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 10.sp,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
                Text(
                  '${widget.itemCount} ${S.of(context).video}',
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: watch.isLoading
          ? const Center(
              child: LoadingWidget(),
            )
          : Scaffold(
              body: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollDetails) {
                    if (!watch.isLoading &&
                        watch.videos.length != int.parse(widget.itemCount) &&
                        scrollDetails.metrics.pixels ==
                            scrollDetails.metrics.maxScrollExtent) {
                      read.loadMoreVideos(playlistId: widget.id);
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: 1 + watch.videos.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return _buildHeadPlaylist();
                      }

                      Video video = watch.videos[index - 1];
                      if (watch.videos.isEmpty) {
                        return Center(
                          child: Text(
                            S.of(context).scrollToUpForLoad,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          watch.videos.isNotEmpty
                              ? CardVideo(video: video, index: index)
                              : const LoadingWidget(),
                          index == watch.videos.length
                              ? index != int.parse(widget.itemCount)
                                  ? const CircularProgressIndicator()
                                  : 0.sh
                              : 0.sh
                        ],
                      );
                    },
                  ))),
    );
  }
}
