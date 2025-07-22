import 'package:eco_step/features/counter/domain/repositories/counter_repository.dart';

class IncrementCounterUseCase {
  final CounterRepository _repository;

  IncrementCounterUseCase(this._repository);

  void call() {
    final currentCount = _repository.getCurrentCount();
    _repository.updateCount(currentCount + 1);
  }
}
