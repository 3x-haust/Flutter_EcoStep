import 'package:eco_step/features/news/domain/entities/news_entity.dart';
import 'package:get/get.dart';

class NewsViewModel extends GetxController {
  final RxList<NewsEntity> _newsList = <NewsEntity>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _selectedDate = '23'.obs;
  final RxInt _selectedDateIndex = 3.obs;
  final RxMap<String, double> _readingProgress = <String, double>{}.obs;

  List<NewsEntity> get newsList => _newsList;
  bool get isLoading => _isLoading.value;
  String get selectedDate => _selectedDate.value;
  int get selectedDateIndex => _selectedDateIndex.value;
  Map<String, double> get readingProgress => _readingProgress;

  @override
  void onInit() {
    super.onInit();
    loadMockNews();
  }

  void loadMockNews() {
    _isLoading.value = true;
    
    final mockNews = [
      NewsEntity(
        id: '1',
        title: '캘리포니아를 덮친 초대형 홍수, 어떻게 일본에서 시작되나?',
        content: '''2월의 어느 이른 아침, 미 공군에서 폭풍 관측 임무를 맡고 있는 파일럿 네이트 워달 대위가 도쿄 서쪽 요코타 공군기지에서 이륙했다. 목적지는 일본 연안에서 발달 중이던 폭풍, '대기천'이었다. 그는 대기천에 닿기 위해 후지산에서 불어오는 난기류를 뚫고 광활하고 푸른 태평양으로 향했다.

대기천은 하늘에 있는 수증기의 리본으로, 육안으로는 보이지 않는다. 워달 대위가 추적하는 대기천은 보통 태평양에서 만들어진 후, 미국 서부 해안을 향해 동쪽으로 이동한다. 대기천이 해안에 닿으면 산맥을 타고 올라간다. 이 과정에서 수증기가 차가워져 비나 눈의 형태로 지상으로 떨어지면서, 파괴적인 홍수와 눈사태를 일으킬 수 있다. 하지만 대기천은 가뭄 예방에도 중요한 역할을 한다. 캘리포니아 연간 강수량의 최대 50%를 며칠만에 채워주는 것이 대기천으로 인한 눈이나 비다. 이러한 대기천은 보통 겨울에 만들어지기 때문에, 워달 대위처럼 이와 관련된 자료를 모으는 파일럿은 여름에는 허리케인을 좇고 겨울에는 대기천을 추적한다.

워달 대위는 공군 제53기상정찰대대 소속으로 폭풍을 관측한다. 그는 "우리의 연간 주요 임무는 허리케인 관측"이라고 말했다. 보통 5월부터 11월까지는 허리케인을 관측한다. 비행기로 허리케인 안에 들어간 뒤 기상 관측기구를 떨어뜨린다. 그리고 관측기구가 수집한 실시간 데이터를 국립 허리케인 센터로 보내는 것이 임무다. 그는 "최근 몇 년새 여름 허리케인 시즌이 끝나면, 대기천 임무를 수행하고 있다"고 말했다. 일반적으로 11월에서 3월까지 대기천으로 인한 폭풍 데이터를 수집한다.

그동안은 하와이와 미국 서부 해안에서 비행기를 띄워 대기천 관측을 해왔다. 하지만 올해부터는 일본에서 비행기를 띄워 대기천을 관측하는 임무도 추가되었다. 폭풍이 만들어진 초기부터 자료를 모아, 예보의 정확도를 높이기 위해서다.

극단적 기상현상 전문가인 안나 윌슨은 일반적으로 "북반구에서 일어나는 기상 현상은 서쪽에서 동쪽으로 이동한다"며 "폭풍에 대한 정확한 정보가 더 많을수록 폭풍이 어떻게 진화할지 더 잘 예측할 수 있을 것"이라고 말했다. '폭풍이 육지에 상륙 후 얼마나 많은 비나 눈을 내릴지' 등도 예측의 한 분야다. 윌슨은 국립해양대기청(Noaa)과 함께 이 임무를 진행 중인 샌디에이고 캘리포니아 대학 스크립스 해양연구소에서 서부 기상·수자원 극한 센터 현장 연구 관리자로 일하고 있다.''',
        coverImageUrl: './assets/images/cover.png',
        authorName: '소피 하닥',
        publishedDate: '2025년 5월 31일',
        newsSource: 'BBC',
        newsSourceLogo: 'assets/icons/logo.svg',
        contentImages: [
          NewsImageEntity(
            imageUrl: './assets/images/content.png',
            caption: '제53기상정찰대(53WRS) 지휘관 스티븐 피터치 중령과 네이트 워달 대위가 일본으로 가는 도중 콰잘레인 섬에 착륙했다',
            source: 'U.S. Air Force',
          ),
        ],
      ),
    ];

    Future.delayed(const Duration(milliseconds: 500), () {
      _newsList.assignAll(mockNews);
      _isLoading.value = false;
    });
  }

  void selectDate(int index, String date) {
    _selectedDateIndex.value = index;
    _selectedDate.value = date;
  }

  void refreshNews() {
    loadMockNews();
  }

  NewsEntity? getTodayNews() {
    if (_newsList.isNotEmpty) {
      return _newsList.first;
    }
    return null;
  }

  double getNewsReadingProgress(String newsId) {
    return _readingProgress[newsId] ?? 0.0;
  }

  void updateReadingProgress(String newsId, double progress) {
    _readingProgress[newsId] = progress;
  }
}
