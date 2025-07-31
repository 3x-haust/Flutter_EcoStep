import 'package:eco_step/features/history/domain/entities/history_item.dart';
import 'package:eco_step/features/history/domain/repositories/history_repository.dart';

class GetHistoryItemsUseCase {
  final HistoryRepository _repository;

  GetHistoryItemsUseCase(this._repository);

  Future<List<HistoryItem>> call() async {
    return await _repository.getHistoryItems();
  }
}
