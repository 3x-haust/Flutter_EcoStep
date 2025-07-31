import 'package:eco_step/core/di/injection.dart';
import 'package:eco_step/features/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileViewModel>(getIt<ProfileViewModel>());
  }
}
