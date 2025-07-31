import 'package:eco_step/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile?> getCurrentProfile();
  Future<void> signOut();
}
