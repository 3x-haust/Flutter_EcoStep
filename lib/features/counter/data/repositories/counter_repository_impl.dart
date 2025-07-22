import 'package:eco_step/features/counter/domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  int _count = 0;

  @override
  int getCurrentCount() {
    return _count;
  }

  @override
  void updateCount(int count) {
    _count = count;
  }
}
