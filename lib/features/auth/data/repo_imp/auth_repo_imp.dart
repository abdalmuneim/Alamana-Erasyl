// data/repositories/auth_repository_impl.dart

import 'package:alamanaelrasyl/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:alamanaelrasyl/features/auth/data/models/user_model.dart';
import 'package:alamanaelrasyl/features/auth/domin/repo/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;

  AuthRepositoryImpl(this.firebaseAuthDataSource);

  @override
  Future<UserModel?> signInWithGoogle() async {
    return await firebaseAuthDataSource.signInWithGoogle();
  }

  @override
  Future<UserModel?> getUserData(String uid) async {
    return await firebaseAuthDataSource.getUserData(uid);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuthDataSource.signOut();
  }
}
