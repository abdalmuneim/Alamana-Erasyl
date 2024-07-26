import 'package:alamanaelrasyl/core/helper/fun_helper.dart';
import 'package:alamanaelrasyl/core/resources/app_string.dart';
import 'package:alamanaelrasyl/core/resources/assets_manager.dart';
import 'package:alamanaelrasyl/core/utilities/extensions.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/data/models/fatwa_model.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class CardForFatwa extends StatefulWidget {
  const CardForFatwa({super.key, required this.fatwa});
  final FatwaModel fatwa;
  @override
  State<CardForFatwa> createState() => _CardForFatwaState();
}

class _CardForFatwaState extends State<CardForFatwa> {
  bool isVisibaleReply = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// fatwa content
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(),
                    ),
                    child: SvgPicture.asset(Assets.userOctagon)),
                1.w.sw,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.fatwa.deviceID?.substring(0, 7) ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    .4.h.sh,
                    Text(
                      widget.fatwa.createAt ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                )
              ],
            ),
            2.h.sh,

            Text(widget.fatwa.fatwaDescription ?? ""),
            2.h.sh,

            /// data replay and share
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                8.w.sw,
                Visibility(
                  visible: (widget.fatwa.reply != null),
                  child: Text(S.of(context).replayDone),
                ),
                const Spacer(),
                Visibility(
                  visible: (widget.fatwa.shareCount != null),
                  child:
                      Text(S.of(context).shared(widget.fatwa.shareCount ?? "")),
                ),
                8.w.sw,
              ],
            ),

            /// icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    print(isVisibaleReply);
                    setState(() {
                      isVisibaleReply = !isVisibaleReply;
                    });
                  },
                  icon: const Icon(Icons.comment_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
              ],
            ),
            Visibility(
              visible: !isVisibaleReply && widget.fatwa.reply != null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.w),
                        margin: EdgeInsets.only(right: 8.w, left: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(),
                          image: DecorationImage(
                            image: AssetImage(
                              Assets.sanad,
                            ),
                          ),
                        ),
                      ),
                      1.w.sw,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.fatwa.repliedName ??
                                FunHelper.removeFirstWord(AppString.sanad),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          .4.h.sh,
                          Text(
                            widget.fatwa.replyAt ?? "",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Text(
                      widget.fatwa.reply ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
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
}
