import 'package:easy_localization/easy_localization.dart';
import 'package:eco_step/features/home/presentation/widgets/date_selector_widget.dart';
import 'package:eco_step/core/util/app_state_manager.dart';
import 'package:eco_step/features/quiz/presentation/views/quiz_page.dart';
import 'package:eco_step/features/climate_mission/presentation/views/climate_mission_page.dart';
import 'package:eco_step/features/lockscreen_quiz/presentation/controllers/lockscreen_quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/core/widgets/common/my_app_bar.dart';
import 'package:eco_step/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:eco_step/features/news/presentation/views/news_detail_page.dart';
import 'package:eco_step/features/news/domain/entities/news_entity.dart';
import 'package:eco_step/features/news/presentation/viewmodels/news_viewmodel.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    final homeViewModel = Get.find<HomeViewModel>();
    final newsViewModel = Get.put(NewsViewModel());

    return Scaffold(
      backgroundColor: colors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => MyAppBar(
            streakCount: homeViewModel.streakCount,
            lastCompletedDate: homeViewModel.lastCompletedDate,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DateSelectorWidget(),
            buildTodayNewsSection(context, colors, newsViewModel),
            const SizedBox(height: 36),
            AppStateManager.getButtonText() != 'done'
                ? buildQuizSection(context, colors)
                : Container(),
            const SizedBox(height: 20),
            buildLockscreenQuizTestSection(context, colors),
          ],
        ),
      ),
    );
  }

  Widget buildTodayNewsSection(
    BuildContext context,
    ThemeColors colors,
    NewsViewModel newsViewModel,
  ) {
    return ClipRRect(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(
                    context.tr('home.todayNews'),
                    style: Typo.titleStrong(context, color: colors.gray900),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final todayNews = newsViewModel.getTodayNews();
              if (todayNews == null) {
                return const SizedBox(height: 170);
              }

              return GestureDetector(
                onTap: () {
                  Get.to(NewsDetailPage(news: todayNews));
                },
                child: Column(
                  children: [
                    buildNewsCard(colors, todayNews, newsViewModel),
                    const SizedBox(height: 8),
                    buildNewsInfo(context, colors, todayNews),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildNewsCard(
    ThemeColors colors,
    NewsEntity news,
    NewsViewModel newsViewModel,
  ) {
    return Builder(
      builder: (context) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Container(
              width: 340,
              height: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _getImageProvider(news.coverImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(46, 46, 46, 0.8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/icons/${news.newsSource.toLowerCase()}.svg',
                  width: 60,
                  height: 17,
                  colorFilter: ColorFilter.mode(
                    colors.gray900,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            if (AppStateManager.shouldShowQuizButton())
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF000000).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        await Get.to(() => const QuizPage());
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          context.tr('news.takeQuiz'),
                          style: Typo.titleStrong(
                            context,
                            color: colors.gray900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Obx(() {
                final progress = newsViewModel.getNewsReadingProgress(news.id);
                return SizedBox(
                  height: 4,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: colors.gray40,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF00A267),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNewsInfo(
    BuildContext context,
    ThemeColors colors,
    NewsEntity news,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          news.title,
          style: Typo.bodyStrong(context, color: colors.gray900),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          news.publishedDate,
          style: Typo.footnoteRegular(context, color: colors.gray300),
        ),
      ],
    );
  }

  Widget buildLockscreenQuizTestSection(BuildContext context, ThemeColors colors) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lockscreen Quiz Test',
            style: Typo.titleStrong(context, color: colors.gray900),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final controller = Get.find<LockscreenQuizController>();
                    controller.showRandomQuizNotification();
                    Get.snackbar(
                      'Test',
                      'Lockscreen quiz notification sent!',
                      backgroundColor: colors.primary,
                      colorText: colors.background,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Show Quiz Notification',
                      style: Typo.bodyStrong(context, color: colors.background),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final controller = Get.find<LockscreenQuizController>();
                    controller.startPeriodicQuizNotifications();
                    Get.snackbar(
                      'Test',
                      'Periodic notifications started!',
                      backgroundColor: colors.primary,
                      colorText: colors.background,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: colors.gray600,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Start Periodic',
                      style: Typo.bodyStrong(context, color: colors.background),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildQuizSection(BuildContext context, ThemeColors colors) {
    return GestureDetector(
      onTap: () async {
        final currentState = AppStateManager.currentState;
        switch (currentState) {
          case AppState.newsNotRead:
            final newsViewModel = Get.find<NewsViewModel>();
            final todayNews = newsViewModel.getTodayNews();
            if (todayNews != null) {
              await Get.to(NewsDetailPage(news: todayNews));
              setState(() {});
            }
            break;
          case AppState.newsRead:
          case AppState.quizInProgress:
            await Get.to(() => const QuizPage());
            setState(() {});
            break;
          case AppState.quizCompleted:
            await Get.to(() => const ClimateMissionPage());
            setState(() {});
            break;
          case AppState.missionCompleted:
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        decoration: BoxDecoration(
          color: colors.gray0,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 33.63,
              height: 34.04,
              decoration: BoxDecoration(
                color: colors.gray30,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.icons.step.path,
                  width: 16,
                  height: 18,
                  colorFilter: ColorFilter.mode(
                    colors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 19),
            Text(
              AppStateManager.getButtonText(),
              style: Typo.bodyRegular(context, color: colors.gray900),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return NetworkImage(imagePath);
    } else {
      return AssetImage(imagePath);
    }
  }
}
