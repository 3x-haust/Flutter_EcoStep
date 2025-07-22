import 'package:eco_step/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> signInWithGoogle();
  Future<void> signOut();
  Future<User?> getCurrentUser();
  Stream<User?> get authStateChanges;
}