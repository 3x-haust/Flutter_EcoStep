import 'package:eco_step/features/news/presentation/viewmodels/news_viewmodel.dart';
import 'package:get/get.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsViewModel>(() => NewsViewModel());
  }
}
