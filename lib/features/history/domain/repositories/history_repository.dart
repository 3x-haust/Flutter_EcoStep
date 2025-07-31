import 'package:eco_step/features/history/domain/entities/history_item.dart';

abstract class HistoryRepository {
  Future<List<HistoryItem>> getHistoryItems();
  Future<HistoryItem?> getHistoryItemById(String id);
}
