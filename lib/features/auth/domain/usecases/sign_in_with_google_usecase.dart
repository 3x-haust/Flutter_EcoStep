import 'package:eco_step/features/auth/domain/entities/user.dart';
import 'package:eco_step/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _repository;

  SignInWithGoogleUseCase(this._repository);

  Future<User?> call() async {
    return await _repository.signInWithGoogle();
  }
}