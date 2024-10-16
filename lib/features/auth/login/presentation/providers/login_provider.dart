import 'dart:developer';

import 'package:alamanaelrasyl/core/navigator/navigator_utils.dart';
import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/utilities/utilities.dart';
import 'package:alamanaelrasyl/features/auth/data/models/user_model.dart';
import 'package:alamanaelrasyl/features/auth/domin/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginProvider extends ChangeNotifier {
  // presentation/provider/auth_provider.dart
  UserModel? _user;
  final AuthRepository _authRepository;

  LoginProvider(this._authRepository);

  UserModel? get user => _user;

  // Sign in with Google
  Future<void> signIn() async {
    await _authRepository.signInWithGoogle().then((value) {
      if (value != null) {
        _user = value;
        NavigationService.context.goNamed(RouteNameStrings.bottomNavBar);
      }
    }).catchError((onError) {
      log(onError.toString());
      Utils.showErrorToast(onError.toString());
    });
  }

  // Sign out
  Future<void> signOut() async {
    await _authRepository.signOut();
    _user = null;
    notifyListeners();
  }
}
