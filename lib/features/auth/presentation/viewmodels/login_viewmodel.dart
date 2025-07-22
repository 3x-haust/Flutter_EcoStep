import 'package:eco_step/features/auth/domain/entities/user.dart';
import 'package:eco_step/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  LoginViewModel(this._signInWithGoogleUseCase);

  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  Future<void> signInWithGoogle() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      final user = await _signInWithGoogleUseCase.call();
      
      if (user != null) {
        _user.value = user;
        Get.offAllNamed('/');
      } else {
        _errorMessage.value = '로그인에 실패했습니다.';
      }
    } catch (e) {
      _errorMessage.value = '로그인 중 오류가 발생했습니다: ${e.toString()}';
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }
}