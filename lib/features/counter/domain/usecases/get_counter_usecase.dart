import 'package:eco_step/features/counter/domain/entities/counter.dart';
import 'package:eco_step/features/counter/domain/repositories/counter_repository.dart';

class GetCounterUseCase {
  final CounterRepository _repository;

  GetCounterUseCase(this._repository);

  Counter call() {
    final count = _repository.getCurrentCount();
    return Counter(value: count);
  }
}
