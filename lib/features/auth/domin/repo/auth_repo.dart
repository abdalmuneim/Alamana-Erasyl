// domain/repositories/auth_repository.dart

import 'package:alamanaelrasyl/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> signInWithGoogle();
  Future<void> signOut();
  Future<UserModel?> getUserData(String uid);

}
