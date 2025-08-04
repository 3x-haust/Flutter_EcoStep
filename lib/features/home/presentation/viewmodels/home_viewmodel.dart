import 'package:eco_step/features/history/domain/entities/history_item.dart';
import 'package:eco_step/features/history/domain/usecases/get_history_items_usecase.dart';
import 'package:eco_step/features/auth/domain/entities/user.dart';
import 'package:eco_step/features/profile/domain/usecases/get_current_profile_usecase.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final GetHistoryItemsUseCase _getHistoryItemsUseCase;
  final GetCurrentProfileUseCase _getCurrentProfileUseCase;

  HomeViewModel(
    this._getHistoryItemsUseCase,
    this._getCurrentProfileUseCase,
  );

  final RxList<HistoryItem> _historyItems = <HistoryItem>[].obs;
  List<HistoryItem> get historyItems => _historyItems;

  final Rx<User?> _currentUser = Rx<User?>(null);
  User? get currentUser => _currentUser.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxInt _streakCount = 0.obs;
  int get streakCount => _streakCount.value;

  final Rx<DateTime?> _lastCompletedDate = Rx<DateTime?>(null);
  DateTime? get lastCompletedDate => _lastCompletedDate.value;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading.value = true;
    try {
      await Future.wait([
        _loadHistoryItems(),
        _loadCurrentUser(),
      ]);
      _calculateStreak();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _loadHistoryItems() async {
    try {
      final items = await _getHistoryItemsUseCase.call();
      _historyItems.assignAll(items);
    } catch (e) {
      print('Error loading history items: $e');
    }
  }

  Future<void> _loadCurrentUser() async {
    try {
      final profile = await _getCurrentProfileUseCase.call();
      if (profile != null) {
        _currentUser.value = User(
          id: profile.id,
          email: profile.email,
          name: profile.name,
          profileImageUrl: profile.profileImageUrl,
        );
      }
    } catch (e) {
      print('Error loading current user: $e');
    }
  }

  void _calculateStreak() {
    if (_historyItems.isEmpty) {
      _streakCount.value = 0;
      _lastCompletedDate.value = null;
      return;
    }

    final sortedItems = List<HistoryItem>.from(_historyItems)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    int streak = 0;
    DateTime? checkDate = today;
    DateTime? lastCompleted;

    for (final item in sortedItems) {
      final itemDate = DateTime(
        item.createdAt.year,
        item.createdAt.month,
        item.createdAt.day,
      );

      if (checkDate == null) break;

      if (itemDate == checkDate) {
        streak++;
        lastCompleted = itemDate;
        checkDate = DateTime(
          checkDate.year,
          checkDate.month,
          checkDate.day - 1,
        );
      } else if (itemDate.isBefore(checkDate)) {
        final daysDiff = checkDate.difference(itemDate).inDays;
        if (daysDiff == 1) {
          streak++;
          lastCompleted = itemDate;
          checkDate = DateTime(
            itemDate.year,
            itemDate.month,
            itemDate.day - 1,
          );
        } else {
          break;
        }
      }
    }

    _streakCount.value = streak;
    _lastCompletedDate.value = lastCompleted;
  }

  Future<void> refreshData() async {
    await _loadData();
  }
}
