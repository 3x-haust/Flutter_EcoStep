import 'package:eco_step/core/di/injection.dart';
import 'package:eco_step/core/util/style/theme.dart';
import 'package:eco_step/features/auth/domain/repositories/auth_repository.dart';
import 'package:eco_step/features/auth/presentation/bindings/login_binding.dart';
import 'package:eco_step/features/auth/presentation/views/login_view.dart';
import 'package:eco_step/features/bindings/main_binding.dart';
import 'package:eco_step/features/main.dart';
import 'package:eco_step/features/profile/presentation/bindings/profile_binding.dart';
import 'package:eco_step/features/profile/presentation/views/profile_view.dart';
import 'package:eco_step/firebase_options.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: Assets.config.aEnv);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
        Locale('bn', 'BD'),
        Locale('uz', 'UZ'),
        Locale('th', 'TH'),
        Locale('fil', 'PH'),
        Locale('rw', 'RW'),
        Locale('id', 'ID'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late bool isLoggedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final authRepository = getIt.get<AuthRepository>();
      final currentUser = await authRepository.getCurrentUser();
      
      setState(() {
        isLoggedIn = currentUser != null;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoggedIn = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(),
        theme: initThemeData(brightness: Brightness.light),
        darkTheme: initThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.system,
      );
    }

    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => const MainPage(),
          binding: MainBinding(),
        ),
        GetPage(
          name: '/profile',
          page: () => const ProfileView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginView(),
          binding: LoginBinding(),
        ),
      ],
      initialRoute: isLoggedIn ? '/' : '/login',
      debugShowCheckedModeBanner: false,
      theme: initThemeData(brightness: Brightness.light),
      darkTheme: initThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

