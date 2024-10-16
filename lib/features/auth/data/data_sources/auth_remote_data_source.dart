// data/datasources/firebase_auth_datasource.dart

import 'package:alamanaelrasyl/core/services/firebase_collec.dart';
import 'package:alamanaelrasyl/core/services/get_device_id.dart';
import 'package:alamanaelrasyl/core/services/notification_service.dart';
import 'package:alamanaelrasyl/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Google sign-in
  Future<UserModel?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // Canceled

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      // Store user in Firestore
      UserModel userModel = UserModel(
        id: user.uid,
        deviceId: await GetDeviceId.instance.getDeviceId(),
        email: user.email,
        fcmToken: await NotificationServiceImpl().getFCMToken(),
        image: user.photoURL,
        name: user.displayName,
        phone: user.phoneNumber,
      );
      await _createUserInFirestore(userModel);
      await _updateFCMTokenCollectionWithId(userModel);
      return userModel;
    }

    return null;
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Create user document in Firestore
  Future<void> _createUserInFirestore(UserModel user) async {
    DocumentReference userDoc =
        FirebaseCollec.instance.userCollection.doc(user.id);
    if (!(await userDoc.get()).exists) {
      userDoc.set(user.toMap());
    }
  }

  _updateFCMTokenCollectionWithId(UserModel user) {
    FirebaseCollec.instance.fcmTokenCollection(deviceID: user.id ?? "", data: {
      "deviceId": user.deviceId,
      "fcmToken": user.fcmToken,
      "updateAt": FieldValue.serverTimestamp(),
      "id": user.id,
    });
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseCollec.instance.userCollection.doc(uid).get();

      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}
