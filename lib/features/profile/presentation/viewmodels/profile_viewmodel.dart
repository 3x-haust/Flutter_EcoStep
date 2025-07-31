import 'package:eco_step/features/profile/domain/entities/profile.dart';
import 'package:eco_step/features/profile/domain/usecases/get_current_profile_usecase.dart';
import 'package:eco_step/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController {
  final GetCurrentProfileUseCase _getCurrentProfileUseCase;
  final SignOutUseCase _signOutUseCase;

  ProfileViewModel(
    this._getCurrentProfileUseCase,
    this._signOutUseCase,
  );

  final Rx<Profile?> _profile = Rx<Profile?>(null);
  Profile? get profile => _profile.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      final profile = await _getCurrentProfileUseCase.call();
      _profile.value = profile;
      
      if (profile == null) {
        _errorMessage.value = '프로필을 불러올 수 없습니다.';
      }
    } catch (e) {
      _errorMessage.value = '프로필을 불러오는 중 오류가 발생했습니다.';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading.value = true;
      await _signOutUseCase.call();
      Get.offAllNamed('/login');
    } catch (e) {
      _errorMessage.value = '로그아웃 중 오류가 발생했습니다.';
    } finally {
      _isLoading.value = false;
    }
  }

  void onEditProfile() {
    Get.toNamed('/profile/edit');
  }
}
