import 'package:eco_step/features/counter/domain/entities/counter.dart';
import 'package:eco_step/features/counter/domain/usecases/decrement_counter_usecase.dart';
import 'package:eco_step/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:eco_step/features/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:get/get.dart';

class CounterViewModel extends GetxController {
  final GetCounterUseCase _getCounterUseCase;
  final IncrementCounterUseCase _incrementCounterUseCase;
  final DecrementCounterUseCase _decrementCounterUseCase;

  CounterViewModel(
    this._getCounterUseCase,
    this._incrementCounterUseCase,
    this._decrementCounterUseCase,
  );

  final Rx<Counter> _counter = const Counter().obs;
  Counter get counter => _counter.value;

  @override
  void onInit() {
    super.onInit();
    _loadCounter();
  }

  void _loadCounter() {
    _counter.value = _getCounterUseCase.call();
  }

  void increment() {
    _incrementCounterUseCase.call();
    _loadCounter();
  }

  void decrement() {
    _decrementCounterUseCase.call();
    _loadCounter();
  }
}
