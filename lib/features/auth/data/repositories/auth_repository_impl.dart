import 'package:eco_step/features/auth/domain/entities/user.dart';
import 'package:eco_step/features/auth/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '175617267854-h0g9bm92abq7ugp0dc966a32bth1sn9p.apps.googleusercontent.com',
  );

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      return User(
        id: googleUser.id,
        email: googleUser.email,
        name: googleUser.displayName ?? '',
        profileImageUrl: googleUser.photoUrl,
      );
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
    if (googleUser != null) {
      return User(
        id: googleUser.id,
        email: googleUser.email,
        name: googleUser.displayName ?? '',
        profileImageUrl: googleUser.photoUrl,
      );
    }
    return null;
  }

  @override
  Stream<User?> get authStateChanges {
    return const Stream<User?>.empty();
  }
}