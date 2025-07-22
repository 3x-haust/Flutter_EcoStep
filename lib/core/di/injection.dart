import 'package:eco_step/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eco_step/features/auth/domain/repositories/auth_repository.dart';
import 'package:eco_step/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:eco_step/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:eco_step/features/counter/data/repositories/counter_repository_impl.dart';
import 'package:eco_step/features/counter/domain/repositories/counter_repository.dart';
import 'package:eco_step/features/counter/domain/usecases/decrement_counter_usecase.dart';
import 'package:eco_step/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:eco_step/features/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:eco_step/features/counter/presentation/viewmodels/counter_viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Auth dependencies
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );

  getIt.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<LoginViewModel>(
    () => LoginViewModel(getIt<SignInWithGoogleUseCase>()),
  );

  // Counter dependencies
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
