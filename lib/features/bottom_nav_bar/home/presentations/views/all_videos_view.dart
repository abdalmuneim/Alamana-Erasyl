import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/widgets/card_video.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
                      return CardVideo(video: video);
                    },
                  ),
                )
              : const LoadingWidget()),
    );
  }
}
