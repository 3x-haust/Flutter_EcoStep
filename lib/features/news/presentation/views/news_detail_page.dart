import 'package:easy_localization/easy_localization.dart';
import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/core/util/app_state_manager.dart';
import 'package:eco_step/features/news/domain/entities/news_entity.dart';
import 'package:eco_step/features/news/presentation/widgets/reading_progress_widget.dart';
import 'package:eco_step/features/news/presentation/viewmodels/news_viewmodel.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsEntity news;

  const NewsDetailPage({super.key, required this.news});

  @override
  NewsDetailPageState createState() => NewsDetailPageState();
}

class NewsDetailPageState extends State<NewsDetailPage> {
  final ScrollController scrollController = ScrollController();
  double readingProgress = 0.0;
  bool isCompleted = false;
  late NewsViewModel newsViewModel;

  @override
  void initState() {
    super.initState();
    newsViewModel = Get.find<NewsViewModel>();
    scrollController.addListener(updateReadingProgress);
    readingProgress = newsViewModel.getNewsReadingProgress(widget.news.id);
  }

  @override
  void dispose() {
    final currentSavedProgress = newsViewModel.getNewsReadingProgress(
      widget.news.id,
    );
    if (readingProgress > currentSavedProgress) {
      newsViewModel.updateReadingProgress(widget.news.id, readingProgress);
    }

    scrollController.removeListener(updateReadingProgress);
    scrollController.dispose();
    super.dispose();
  }

  void updateReadingProgress() {
    if (scrollController.hasClients) {
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      final currentPosition = scrollController.position.pixels;

      setState(() {
        readingProgress = maxScrollExtent > 0
            ? currentPosition / maxScrollExtent
            : 0.0;
        readingProgress = readingProgress.clamp(0.0, 1.0);

        final currentSavedProgress = newsViewModel.getNewsReadingProgress(
          widget.news.id,
        );
        if (readingProgress > currentSavedProgress) {
          newsViewModel.updateReadingProgress(widget.news.id, readingProgress);
        }

        if (readingProgress >= 0.9 && !isCompleted) {
          isCompleted = true;
          AppStateManager.markNewsAsRead();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ReadingProgressWidget(progress: readingProgress),
            Expanded(child: buildContent(colors)),
          ],
        ),
      ),
    );
  }

  Widget buildContent(ThemeColors colors) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          buildHeader(colors),
          const SizedBox(height: 48),
          buildArticleContent(colors),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget buildHeader(ThemeColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.news.title,
          style: Typo.titleStrong(context, color: colors.gray900),
        ),
        const SizedBox(height: 6),
        buildCoverImage(colors),
        const SizedBox(height: 10),
        buildNewsInfo(colors),
      ],
    );
  }

  Widget buildCoverImage(ThemeColors colors) {
    return Stack(
      children: [
        Container(
          width: 340,
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: _getImageProvider(widget.news.coverImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(46, 46, 46, 0.8),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
            ),
            child: Text(
              'Getty Images', // 이미지 출처
              style: Typo.captionRegular(context, color: colors.gray900),
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider _getImageProvider(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return NetworkImage(imagePath);
    } else {
      return AssetImage(imagePath);
    }
  }

  Widget buildNewsInfo(ThemeColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.news.authorName,
              style: Typo.bodyStrong(context, color: colors.gray900),
            ),
            Text(
              widget.news.publishedDate,
              style: Typo.footnoteRegular(context, color: colors.gray300),
            ),
          ],
        ),
        SvgPicture.asset(
          Assets.icons.bbc.path,
          width: 60,
          height: 17,
          colorFilter: ColorFilter.mode(colors.gray300, BlendMode.srcIn),
        ),
      ],
    );
  }

  Widget buildArticleContent(ThemeColors colors) {
    final paragraphs = widget.news.content.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < paragraphs.length; i++) ...[
          Text(
            paragraphs[i],
            style: Typo.bodyRegular(context, color: colors.gray900),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 24),
          if (i == 0 && widget.news.contentImages.isNotEmpty)
            buildContentImage(widget.news.contentImages.first, colors),
        ],
      ],
    );
  }

  Widget buildContentImage(NewsImageEntity imageEntity, ThemeColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 340,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: _getImageProvider(imageEntity.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(46, 46, 46, 0.8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Text(
                  imageEntity.source,
                  style: Typo.captionRegular(context, color: colors.gray900),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          imageEntity.caption,
          style: Typo.footnoteRegular(context, color: colors.gray300),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget buildCompletionButton(ThemeColors colors) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('퀴즈 기능이 곧 제공됩니다!')));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                context.tr('news.takeQuiz'),
                style: Typo.titleStrong(context, color: colors.gray900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
