import 'package:eco_step/features/profile/domain/repositories/profile_repository.dart';

class SignOutUseCase {
  final ProfileRepository _repository;

  SignOutUseCase(this._repository);

  Future<void> call() async {
    await _repository.signOut();
  }
}
