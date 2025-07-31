import 'package:eco_step/core/di/injection.dart';
import 'package:eco_step/features/history/presentation/viewmodels/history_viewmodel.dart';
import 'package:get/get.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HistoryViewModel>(getIt<HistoryViewModel>());
  }
}
