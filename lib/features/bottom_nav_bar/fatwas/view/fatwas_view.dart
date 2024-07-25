import 'package:alamanaelrasyl/core/widgets/loading_widget.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/data/models/fatwa_model.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/domin/entities/fatwa.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/provider/fatwas_provider.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                  return ListTile(
                    title: Text(fatwas[index].fatwaDescription ?? ""),
                  );
                },
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: !watch.canAddFatwa
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      ElevatedButton(
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
                        Text(S.of(context).writeYourReqest),
                        const Divider(),
                      ],
                    ),
                    content: Container(
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
                                if (value.length < 70) {
                                  return S
                                      .of(context)
                                      .ValidatorRequestWordNum(70);
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
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
