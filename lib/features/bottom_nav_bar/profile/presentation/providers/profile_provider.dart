import 'package:alamanaelrasyl/core/services/firebase_collec.dart';
import 'package:alamanaelrasyl/features/auth/data/models/user_model.dart';
import 'package:alamanaelrasyl/features/auth/domin/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loggedIn = false;
  bool loading = false;

  UserModel? _user;

  ProfileProvider(this._authRepository);

  UserModel? get user => _user;
  String? userUID;

  _isLoggedIn() async {
    userUID = _auth.currentUser?.uid;
    if (userUID != null) {
      loggedIn = true;
    }
  }

  Future _getUserDataFromFirebase() async {
    loading = true;
    await _isLoggedIn();
    if (loggedIn) {
      await _authRepository.getUserData(userUID!).then((e) {
        _user = e;
      }).catchError((onError) {
        print(onError.toString());
      });
      loading = false;
      notifyListeners();
    }
  }

  init() {
    _getUserDataFromFirebase().then((_) => notifyListeners());
  }
}
