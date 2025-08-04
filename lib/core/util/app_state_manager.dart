
import 'package:easy_localization/easy_localization.dart';

enum AppState {
  newsNotRead,
  newsRead,
  quizInProgress,
  quizCompleted,
  missionCompleted,
}

class AppStateManager {
  static AppState _currentState = AppState.newsNotRead;
  
  static AppState get currentState => _currentState;
  
  static void markNewsAsRead() {
    _currentState = AppState.newsRead;
  }
  
  static void startQuiz() {
    _currentState = AppState.quizInProgress;
  }
  
  static void completeQuiz() {
    _currentState = AppState.quizCompleted;
  }
  
  static void completeMission() {
    _currentState = AppState.missionCompleted;
  }
  
  static String getButtonText() {
    switch (_currentState) {
      case AppState.newsNotRead:
        return 'home.newsNotRead'.tr();
      case AppState.newsRead:
      case AppState.quizInProgress:
        return 'home.quizInProgress'.tr();
      case AppState.quizCompleted:
        return 'home.quizCompleted'.tr();
      case AppState.missionCompleted:
        return 'done';
    }
  }
  
  static bool shouldShowQuizButton() {
    return _currentState == AppState.newsRead || _currentState == AppState.quizInProgress;
  }
}
