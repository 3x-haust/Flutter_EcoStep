import 'package:eco_step/core/di/injection.dart';
import 'package:eco_step/features/history/presentation/viewmodels/history_viewmodel.dart';
import 'package:eco_step/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:eco_step/features/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:eco_step/features/lockscreen_quiz/presentation/controllers/lockscreen_quiz_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileViewModel>(getIt<ProfileViewModel>());
    Get.put<HistoryViewModel>(getIt<HistoryViewModel>());
    Get.put<HomeViewModel>(getIt<HomeViewModel>());
    Get.put<LockscreenQuizController>(getIt<LockscreenQuizController>());
  }
}
