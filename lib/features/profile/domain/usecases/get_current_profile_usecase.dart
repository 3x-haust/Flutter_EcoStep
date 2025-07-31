import 'package:eco_step/features/profile/domain/entities/profile.dart';
import 'package:eco_step/features/profile/domain/repositories/profile_repository.dart';

class GetCurrentProfileUseCase {
  final ProfileRepository _repository;

  GetCurrentProfileUseCase(this._repository);

  Future<Profile?> call() async {
    return await _repository.getCurrentProfile();
  }
}
