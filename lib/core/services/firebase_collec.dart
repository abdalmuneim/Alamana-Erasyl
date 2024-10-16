import 'package:alamanaelrasyl/features/bottom_nav_bar/tazkiyah_al-nafs/data/models/azkar_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollec {
  static FirebaseCollec? _instance;

  // Avoid self instance
  FirebaseCollec._();

  static FirebaseCollec get instance => _instance ??= FirebaseCollec._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fcmTokenCollection(
          {required String deviceID, required Map<String, dynamic> data}) =>
      _firestore.collection("FCM TOKENS").doc(deviceID).set(data);

  CollectionReference<Map<String, dynamic>> get fatwaCollection =>
      _firestore.collection("Fatwas");

  CollectionReference<Map<String, dynamic>> get userCollection =>
      _firestore.collection('Users');

  CollectionReference<Map<String, dynamic>> get azkar =>
      _firestore.collection("Azkar");

  DocumentReference<Map<String, dynamic>> get getAzkarAlsobh =>
      azkar.doc("azkarAlsobh");

  DocumentReference<Map<String, dynamic>> get getazkarAlmasaa =>
      azkar.doc("azkarAlmasaa");

  setAzkarAlsobh(List<AzkarModel> data) async {
    await _firestore
        .collection("Azkar")
        .doc("azkarAlsobh")
        .set({"azkarAlsobh": data.map((e) => e.toMap()).toList()});
  }

  Future<void> setAzkarAlMasaa(List<AzkarModel> data) async {
    await _firestore
        .collection("Azkar")
        .doc("azkarAlmasaa")
        .set({"azkarAlmasaa": data.map((e) => e.toMap()).toList()});
  }

// todo: create myFatwa feature
// todo: create subscription functionality
// todo: make search for playlist and videos
}
