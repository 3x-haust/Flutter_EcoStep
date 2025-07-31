import 'package:eco_step/features/auth/domain/repositories/auth_repository.dart';
import 'package:eco_step/features/profile/domain/entities/profile.dart';
import 'package:eco_step/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter/foundation.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final AuthRepository _authRepository;

  ProfileRepositoryImpl(this._authRepository);

  @override
  Future<Profile?> getCurrentProfile() async {
    try {
      final user = await _authRepository.getCurrentUser();
      if (user == null) return null;

      final points = 100;

      return Profile(
        id: user.id,
        email: user.email,
        name: user.name,
        profileImageUrl: user.profileImageUrl,
        points: points,
      );
    } catch (e) {
      debugPrint('Get Current Profile Error: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}
