import 'package:eco_step/features/auth/domain/entities/user.dart';
import 'package:eco_step/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  User? _currentUser;

  @override
  Future<User?> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 2));
    
    _currentUser = const User(
      id: '1',
      email: 'user@example.com',
      name: 'Test User',
    );
    
    return _currentUser;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
  }

  @override
  Future<User?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Stream<User?> get authStateChanges {
    return Stream.value(_currentUser);
  }
}