import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loggedin = false;

  User? _user;
  User? get user => _user;

  _isLoggedIn() async {
    _user = _auth.currentUser;
    if (_user != null) {
      loggedin = true;
      notifyListeners();
    }
  }

  init() {
    _isLoggedIn();
  }
}
