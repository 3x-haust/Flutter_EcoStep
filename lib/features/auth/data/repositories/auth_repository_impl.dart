import 'package:eco_step/features/auth/domain/entities/user.dart';
import 'package:eco_step/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: dotenv.env['GOOGLE_CLIENT_ID'],
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