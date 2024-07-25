import 'package:alamanaelrasyl/core/navigator/navigator_utils.dart';
import 'package:alamanaelrasyl/core/resources/app_string.dart';
import 'package:alamanaelrasyl/core/resources/assets_manager.dart';
import 'package:alamanaelrasyl/core/services/firebase_collec.dart';
import 'package:alamanaelrasyl/core/services/get_device_id.dart';
import 'package:alamanaelrasyl/core/utilities/utilities.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/data/models/fatwa_model.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/domin/entities/fatwa.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FatwasProvider extends ChangeNotifier {
  final BuildContext context = NavigationService.context;
  late SharedPreferences _preferences;
  final List<Fatwa> _fatwas = [];

  List<Fatwa> get fatwas => _fatwas;
  bool isLoading = false;

  final TextEditingController descriptionController = TextEditingController();
  final FirebaseCollec _firebaseColl = FirebaseCollec.instance;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  addFatwa() async {
    if (globalKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      isLoading = true;
      notifyListeners();

      Map<String, dynamic> data = FatwaModel(
        id: _fatwas.length + 1,
        createAt: DateFormat.yMd("ar").add_jm().format(DateTime.now()),
        deviceID: await GetDeviceId.instance.getDeviceId(),
        fatwaDescription: descriptionController.text,
      ).toMap();
      await _firebaseColl.addFatwaCollection(data: data).then((value) {
        Utils.showToast("Added Successfully and we will replay as soon as!");
      }).catchError((onError) {
        Utils.showErrorToast("SomeThing happened try again later!!");
      });
      isLoading = false;
      notifyListeners();
    } else {
      Utils.showErrorToast(S.of(context).fieldRequired);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFatwas() {
    final Stream<QuerySnapshot<Map<String, dynamic>>> d =
        _firebaseColl.fatwaCollection.snapshots();
    _fatwas.clear();

    d.forEach((QuerySnapshot<Map<String, dynamic>> element) {
      for (var e in element.docs) {
        FatwaModel data = FatwaModel.fromMap(e.data());
        _fatwas.add(data);
      }
    });
    return d;
  }

  init() async {

    _preferences = await SharedPreferences.getInstance();
    await _compareDateNowAndLastFatwaAdded();
  }

  bool _canAddFatwa = true;
  bool get canAddFatwa => _canAddFatwa;

  _compareDateNowAndLastFatwaAdded() async {
    final String? lastDateString = _getLastFatwaDate();

    if (lastDateString != null) {
      final DateTime dateTimeNow = DateFormat.yMd("ar").add_jm().parse(
            DateFormat.yMd("ar").add_jm().format(DateTime.now()),
          );

      final DateTime lastDate =
          DateFormat.yMd("ar").add_jm().parse(lastDateString);

      if (dateTimeNow.isAtSameMomentAs(lastDate) ||
          dateTimeNow.isAfter(lastDate)) {
        _canAddFatwa = true;
        notifyListeners();
      } else {
        _canAddFatwa = false;
        notifyListeners();
      }
    }
  }

  String? _getLastFatwaDate() {
    return _preferences.getString(KeyPreferences.fatwaDateTime);
  }

  _saveAddedFatwaDate() async {
    await _preferences.setString(
      KeyPreferences.fatwaDateTime,
      DateFormat.yMd("ar").add_jm().format(
            DateTime.now(),
          ),
    );
  }
}
