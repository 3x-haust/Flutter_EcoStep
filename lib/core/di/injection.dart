import 'package:eco_step/features/counter/data/repositories/counter_repository_impl.dart';
import 'package:eco_step/features/counter/domain/repositories/counter_repository.dart';
import 'package:eco_step/features/counter/domain/usecases/decrement_counter_usecase.dart';
import 'package:eco_step/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:eco_step/features/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:eco_step/features/counter/presentation/viewmodels/counter_viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(),
  );

  getIt.registerLazySingleton<GetCounterUseCase>(
    () => GetCounterUseCase(getIt<CounterRepository>()),
  );

  getIt.registerLazySingleton<IncrementCounterUseCase>(
    () => IncrementCounterUseCase(getIt<CounterRepository>()),
  );

  getIt.registerLazySingleton<DecrementCounterUseCase>(
    () => DecrementCounterUseCase(getIt<CounterRepository>()),
  );

  getIt.registerLazySingleton<CounterViewModel>(
    () => CounterViewModel(
      getIt<GetCounterUseCase>(),
      getIt<IncrementCounterUseCase>(),
      getIt<DecrementCounterUseCase>(),
    ),
  );
}
