import 'package:eco_step/features/history/domain/entities/history_item.dart';
import 'package:eco_step/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  
  @override
  Future<List<HistoryItem>> getHistoryItems() async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    final items = [
      HistoryItem(
        id: '1',
        title: '텀블러 사용하기',
        content: '일회용 컵 대신 개인 텀블러를 사용해서 환경을 보호했습니다. 카페에서 텀블러 할인도 받았어요!',
        createdAt: today,
        timeString: '',
        isToday: true,
        imageUrl: 'https://example.com/tumbler.jpg',
      ),
      HistoryItem(
        id: '2',
        title: '대중교통 이용하기',
        content: '자가용 대신 지하철을 이용해서 출근했습니다. 탄소 배출량을 줄이는 데 기여했어요.',
        createdAt: today.subtract(const Duration(days: 1)),
        timeString: '',
        isToday: false,
        imageUrl: 'https://example.com/subway.jpg',
      ),
      HistoryItem(
        id: '3',
        title: '분리수거 실천하기',
        content: '플라스틱, 종이, 유리병을 올바르게 분리수거했습니다. 재활용 가능한 자원들을 제대로 처리했어요.',
        createdAt: today.subtract(const Duration(days: 2)),
        timeString: '',
        isToday: false,
        imageUrl: 'https://example.com/recycle.jpg',
      ),
      HistoryItem(
        id: '4',
        title: '전자영수증 받기',
        content: '종이 영수증 대신 전자영수증을 받아 종이 사용량을 줄였습니다.',
        createdAt: today.subtract(const Duration(days: 3)),
        timeString: '',
        isToday: false,
      ),
      HistoryItem(
        id: '5',
        title: '장바구니 이용하기',
        content: '마트에서 장보기 할 때 에코백을 사용해서 비닐봉지 사용을 줄였습니다.',
        createdAt: today.subtract(const Duration(days: 4)),
        timeString: '',
        isToday: false,
        imageUrl: 'https://example.com/ecobag.jpg',
      ),
      HistoryItem(
        id: '6',
        title: '계단 이용하기',
        content: '엘리베이터 대신 계단을 이용해서 전력 사용량을 줄이고 건강도 챙겼습니다.',
        createdAt: today.subtract(const Duration(days: 5)),
        timeString: '',
        isToday: false,
      ),
      HistoryItem(
        id: '7',
        title: '물 절약하기',
        content: '양치할 때 물을 받아서 사용하고, 샤워 시간을 줄여서 물을 절약했습니다.',
        createdAt: today.subtract(const Duration(days: 6)),
        timeString: '',
        isToday: false,
      ),
    ];
    
    return items;
  }

  @override
  Future<HistoryItem?> getHistoryItemById(String id) async {
    final items = await getHistoryItems();
    try {
      return items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
}
