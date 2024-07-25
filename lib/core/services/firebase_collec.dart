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
}
