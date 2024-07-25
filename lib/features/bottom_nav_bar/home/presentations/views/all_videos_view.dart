import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:alamanaelrasyl/core/widgets/loading_widget.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/data/models/video_model.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/all_videos_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/video_view.dart';
import 'package:sizer/sizer.dart';

class AllVideosView extends StatefulWidget {
  const AllVideosView({super.key});

  @override
  State<AllVideosView> createState() => _AllVideosViewState();
}

class _AllVideosViewState extends State<AllVideosView> {
  late final read = context.read<AllVideosProvider>();
  late final watch = context.watch<AllVideosProvider>();

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: VideoView(video: video),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoView(video: video),
          ),
        ); */
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
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl ?? ""),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                children: [
                  Text(
                    video.title ?? "",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 10.sp,
                        ),
                  ),
                  Text(video.description ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 5,
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
              : const LoadingWidget()),
    );
  }
}
