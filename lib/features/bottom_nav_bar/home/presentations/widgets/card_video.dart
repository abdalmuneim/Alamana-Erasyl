import 'package:alamanaelrasyl/core/utilities/extensions.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/data/models/video_model.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/video_view.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:sizer/sizer.dart';

class CardVideo extends StatelessWidget {
  const CardVideo({super.key, required this.video, this.index});
  final Video video;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: VideoView(video: video),
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
            index!=null?Text('$index. '):0.sw,
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
}
