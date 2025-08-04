import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/features/news/domain/entities/news_entity.dart';
import 'package:eco_step/features/news/presentation/viewmodels/news_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsCardWidget extends StatelessWidget {
  final NewsEntity news;
  final VoidCallback onTap;

  const NewsCardWidget({
    super.key,
    required this.news,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    final newsViewModel = Get.find<NewsViewModel>();

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          buildNewsImage(colors, newsViewModel),
          const SizedBox(height: 8),
          buildNewsInfo(colors, context),
        ],
      ),
    );
  }

  Widget buildNewsImage(ThemeColors colors, NewsViewModel newsViewModel) {
    return Container(
      width: 333,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: _getImageProvider(news.coverImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
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
              child: Builder(
                builder: (context) => Text(
                  news.newsSource,
                  style: Typo.captionRegular(context, color: colors.gray900),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -2,
            child: Obx(() {
              final progress = newsViewModel.getNewsReadingProgress(news.id);
              return Container(
                height: 4,
                child: Row(
                  children: [
                    Container(
                      width: 333 * progress,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00A267),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: colors.gray40,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildNewsInfo(ThemeColors colors, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          news.title,
          style: Typo.bodyStrong(context, color: colors.gray900),
        ),
        const SizedBox(height: 2),
        Text(
          news.publishedDate,
          style: Typo.captionRegular(context, color: colors.gray60),
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
}
