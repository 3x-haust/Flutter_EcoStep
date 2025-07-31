import 'package:eco_step/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eco_step/features/auth/domain/repositories/auth_repository.dart';
import 'package:eco_step/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:eco_step/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:eco_step/features/history/data/repositories/history_repository_impl.dart';
import 'package:eco_step/features/history/domain/repositories/history_repository.dart';
import 'package:eco_step/features/history/domain/usecases/get_history_items_usecase.dart';
import 'package:eco_step/features/history/presentation/viewmodels/history_viewmodel.dart';
import 'package:eco_step/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:eco_step/features/profile/domain/repositories/profile_repository.dart';
import 'package:eco_step/features/profile/domain/usecases/get_current_profile_usecase.dart';
import 'package:eco_step/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:eco_step/features/profile/presentation/viewmodels/profile_viewmodel.dart';
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

  // Profile dependencies
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetCurrentProfileUseCase>(
    () => GetCurrentProfileUseCase(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton<ProfileViewModel>(
    () => ProfileViewModel(
      getIt<GetCurrentProfileUseCase>(),
      getIt<SignOutUseCase>(),
    ),
  );

  // History dependencies
  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(),
  );

  getIt.registerLazySingleton<GetHistoryItemsUseCase>(
    () => GetHistoryItemsUseCase(getIt<HistoryRepository>()),
  );

  getIt.registerLazySingleton<HistoryViewModel>(
    () => HistoryViewModel(getIt<GetHistoryItemsUseCase>()),
  );
}
