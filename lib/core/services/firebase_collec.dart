import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollec {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<void> fcmTokenCollection(
          {required String deviceID, required Map<String, dynamic> data}) =>
      _firestore.collection("FCM TOKENS").doc(deviceID).set(data);
  static CollectionReference<Map<String, dynamic>> get fatwaCollection =>
      _firestore.collection("Fatwa");
  static dynamic addFatwaCollection({required Map<String, dynamic> data}) =>
      fatwaCollection.doc().set(data);
}
