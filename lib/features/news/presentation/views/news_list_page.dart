import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/core/widgets/common/my_bottom_navigation_bar.dart';
import 'package:eco_step/features/home/presentation/widgets/date_selector_widget.dart';
import 'package:eco_step/features/news/domain/entities/news_entity.dart';
import 'package:eco_step/features/news/presentation/views/news_detail_page.dart';
import 'package:eco_step/features/news/presentation/widgets/news_card_widget.dart';
import 'package:eco_step/features/news/presentation/viewmodels/news_viewmodel.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  NewsListPageState createState() => NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  int currentBottomIndex = 0;
  late NewsViewModel newsViewModel;

  @override
  void initState() {
    super.initState();
    newsViewModel = Get.put(NewsViewModel());
  }

  void onBottomNavTap(int index) {
    setState(() {
      currentBottomIndex = index;
    });
  }

  void navigateToNewsDetail(NewsEntity news) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(news: news),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray10,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBar(colors),
            const DateSelectorWidget(),
            Expanded(
              child: buildNewsList(colors),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: currentBottomIndex,
        onTap: onBottomNavTap,
      ),
    );
  }

  Widget buildAppBar(ThemeColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Eco\nStep',
            style: Typo.titleStrong(context, color: colors.gray900),
          ),
          Row(
            children: [
              SvgPicture.asset(
                Assets.icons.fireOff.path,
                width: 26,
                height: 30,
                colorFilter: ColorFilter.mode(
                  colors.gray50,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '0',
                style: Typo.titleStrong(context, color: colors.gray50),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNewsList(ThemeColors colors) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            children: [
              Text(
                'Today News',
                style: Typo.titleStrong(context, color: colors.gray900),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (newsViewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              itemCount: newsViewModel.newsList.length,
              itemBuilder: (context, index) {
                final news = newsViewModel.newsList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: NewsCardWidget(
                    news: news,
                    onTap: () => navigateToNewsDetail(news),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
