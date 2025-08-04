import 'package:eco_step/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:eco_step/features/history/domain/usecases/get_history_items_usecase.dart';
import 'package:eco_step/features/profile/domain/usecases/get_current_profile_usecase.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(
      () => HomeViewModel(
        Get.find<GetHistoryItemsUseCase>(),
        Get.find<GetCurrentProfileUseCase>(),
      ),
    );
  }
}
