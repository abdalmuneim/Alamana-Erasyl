import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanad_abu_yousef/core/widgets/loading_widget.dart';
import 'package:sanad_abu_yousef/models/video_model.dart';
import 'package:sanad_abu_yousef/presentations/providers/all_videos_provider.dart';
import 'package:sanad_abu_yousef/presentations/view/video_view.dart';

class AllVideosView extends StatefulWidget {
  @override
  _AllVideosViewState createState() => _AllVideosViewState();
}

class _AllVideosViewState extends State<AllVideosView> {
  late final read = context.read<AllVideosProvider>();
  late final watch = context.watch<AllVideosProvider>();

  _buildVideo(Video video) {
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
          body: watch.channel != null
              ? NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollDetails) {
                    if (!watch.isLoading &&
                        watch.channel!.videos?.length !=
                            int.parse(watch.channel!.videoCount ?? "") &&
                        scrollDetails.metrics.pixels ==
                            scrollDetails.metrics.maxScrollExtent) {
                      read.loadMoreVideos();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: watch.channel!.videos!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Video video = watch.channel!.videos![index];
                      return _buildVideo(video);
                    },
                  ),
                )
              : LoadingWidget()),
    );
  }
}
