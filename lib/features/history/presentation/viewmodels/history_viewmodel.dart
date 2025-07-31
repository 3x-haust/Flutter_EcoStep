import 'package:eco_step/features/history/domain/entities/history_item.dart';
import 'package:eco_step/features/history/domain/usecases/get_history_items_usecase.dart';
import 'package:get/get.dart';

class HistoryViewModel extends GetxController {
  final GetHistoryItemsUseCase _getHistoryItemsUseCase;

  HistoryViewModel(this._getHistoryItemsUseCase);

  final RxList<HistoryItem> _historyItems = <HistoryItem>[].obs;
  List<HistoryItem> get historyItems => _historyItems;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final RxSet<String> _expandedItems = <String>{}.obs;
  Set<String> get expandedItems => _expandedItems;

  @override
  void onInit() {
    super.onInit();
    loadHistoryItems();
  }

  Future<void> loadHistoryItems() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      final items = await _getHistoryItemsUseCase.call();
      _historyItems.assignAll(items);
      
      final todayItem = items.where((item) => item.isToday).firstOrNull;
      if (todayItem != null) {
        _expandedItems.add(todayItem.id);
      }
    } catch (e) {
      _errorMessage.value = '히스토리를 불러오는 중 오류가 발생했습니다.';
    } finally {
      _isLoading.value = false;
    }
  }

  void toggleItemExpansion(HistoryItem item) {
    if (_expandedItems.contains(item.id)) {
      _expandedItems.remove(item.id);
    } else {
      _expandedItems.add(item.id);
    }
  }

  bool isItemExpanded(String itemId) {
    return _expandedItems.contains(itemId);
  }

  void onHistoryItemTap(HistoryItem item) {
    if (!isItemExpanded(item.id)) {
      _expandedItems.clear();
      _expandedItems.add(item.id);
    }
  }

  void onMoreButtonTap(HistoryItem item) {
    Get.toNamed('/history/detail', arguments: item);
  }

  void onDetailButtonTap(HistoryItem item) {
    Get.toNamed('/history/detail', arguments: item);
  }

  String formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}
