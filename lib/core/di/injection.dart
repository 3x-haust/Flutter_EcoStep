import 'package:eco_step/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eco_step/features/auth/domain/repositories/auth_repository.dart';
import 'package:eco_step/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:eco_step/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:eco_step/features/history/data/repositories/history_repository_impl.dart';
import 'package:eco_step/features/history/domain/repositories/history_repository.dart';
import 'package:eco_step/features/history/domain/usecases/get_history_items_usecase.dart';
import 'package:eco_step/features/history/presentation/viewmodels/history_viewmodel.dart';
import 'package:eco_step/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:eco_step/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:eco_step/features/profile/domain/repositories/profile_repository.dart';
import 'package:eco_step/features/profile/domain/usecases/get_current_profile_usecase.dart';
import 'package:eco_step/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:eco_step/features/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:eco_step/features/lockscreen_quiz/data/datasources/lockscreen_quiz_local_datasource.dart';
import 'package:eco_step/features/lockscreen_quiz/data/repositories/lockscreen_quiz_repository_impl.dart';
import 'package:eco_step/features/lockscreen_quiz/domain/repositories/lockscreen_quiz_repository.dart';
import 'package:eco_step/features/lockscreen_quiz/domain/usecases/lockscreen_quiz_usecases.dart';
import 'package:eco_step/features/lockscreen_quiz/presentation/controllers/lockscreen_quiz_controller.dart';
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

  // Home dependencies
  getIt.registerLazySingleton<HomeViewModel>(
    () => HomeViewModel(
      getIt<GetHistoryItemsUseCase>(),
      getIt<GetCurrentProfileUseCase>(),
    ),
  );

  // Lockscreen Quiz dependencies
  getIt.registerLazySingleton<LockscreenQuizLocalDataSource>(
    () => LockscreenQuizLocalDataSource(),
  );

  getIt.registerLazySingleton<LockscreenQuizRepository>(
    () => LockscreenQuizRepositoryImpl(getIt<LockscreenQuizLocalDataSource>()),
  );

  getIt.registerLazySingleton<GetTodayQuizzesUseCase>(
    () => GetTodayQuizzesUseCase(getIt<LockscreenQuizRepository>()),
  );

  getIt.registerLazySingleton<SubmitQuizAnswerUseCase>(
    () => SubmitQuizAnswerUseCase(getIt<LockscreenQuizRepository>()),
  );

  getIt.registerLazySingleton<LockscreenQuizController>(
    () => LockscreenQuizController(
      getTodayQuizzesUseCase: getIt<GetTodayQuizzesUseCase>(),
      submitQuizAnswerUseCase: getIt<SubmitQuizAnswerUseCase>(),
    ),
  );
}
