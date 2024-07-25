import 'package:alamanaelrasyl/core/app_const/constant.dart';
import 'package:alamanaelrasyl/core/resources/assets_manager.dart';
import 'package:alamanaelrasyl/core/utilities/extensions.dart';
import 'package:alamanaelrasyl/core/widgets/loading_widget.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/data/models/fatwa_model.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/domin/entities/fatwa.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/provider/fatwas_provider.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FatwasView extends StatefulWidget {
  const FatwasView({Key? key}) : super(key: key);

  @override
  State<FatwasView> createState() => _FatwasViewState();
}

class _FatwasViewState extends State<FatwasView> {
  late FatwasProvider read = context.read<FatwasProvider>();
  late FatwasProvider watch = context.watch<FatwasProvider>();

  @override
  void initState() {
    read.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.h,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: read.getFatwas(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingWidget());
            }

            List<FatwaModel> fatwas = snapshot.data!.docs
                .map((doc) => FatwaModel.fromMap(doc.data()))
                .toList();
            if (fatwas.isEmpty) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  S.of(context).noFatwaFound,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ));
            } else {
              return ListView.builder(
                itemCount: fatwas.length,
                itemBuilder: (context, index) {
                  final fatwa = fatwas[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
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
                                    fatwa.deviceID?.substring(0, 7) ?? "",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  .4.h.sh,
                                  Text(
                                    fatwa.createAt ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              )
                            ],
                          ),
                          2.h.sh,

                          Text(fatwa.fatwaDescription ?? ""),
                          2.h.sh,

                          /// data replay and share
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              8.w.sw,
                              Visibility(
                                visible: (fatwa.reply != null),
                                child: Text("Replay"),
                              ),
                              const Spacer(),
                              Visibility(
                                visible: (fatwa.shareCount != null),
                                child: Text("Shareed"),
                              ),
                              8.w.sw,
                            ],
                          ),

                          /// icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.comment_outlined),
                              Icon(Icons.share),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: watch.canAddFatwa
          ? FloatingActionButton(
              tooltip: S.of(context).requestFatwa,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      Consumer(builder: (context, FatwasProvider stat, child) {
                    return AlertDialog(
                      actions: [
                        stat.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                onPressed: () => read.addFatwa(),
                                child: Text(
                                  S.of(context).request,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                        TextButton(
                          onPressed: () => read.context.pop(),
                          child: Text(
                            S.of(context).cancel,
                          ),
                        ),
                      ],
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(S.of(context).writeYourRequest),
                          const Divider(),
                        ],
                      ),
                      content: SizedBox(
                        width: 90.w,
                        child: Form(
                          key: watch.globalKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                maxLines: 10,
                                minLines: 5,
                                controller: watch.descriptionController,
                                validator: (value) {
                                  if (value == null) {
                                    return S.of(context).fieldRequired;
                                  }
                                  if (value.length < AppConstant.fatwaLength) {
                                    return S
                                        .of(context)
                                        .ValidatorRequestWordNum(
                                            AppConstant.fatwaLength);
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
              child: const Icon(
                Icons.add,
                size: 33,
              ),
            )
          : null,
    );
  }
}
