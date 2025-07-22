import 'package:eco_step/core/di/injection.dart';
import 'package:eco_step/features/counter/presentation/viewmodels/counter_viewmodel.dart';
import 'package:get/get.dart';

class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CounterViewModel>(() => getIt<CounterViewModel>());
  }
}
