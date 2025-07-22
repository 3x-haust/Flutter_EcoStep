import 'package:eco_step/core/di/injection.dart';
import 'package:eco_step/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(
      () => getIt<LoginViewModel>(),
    );
  }
}
