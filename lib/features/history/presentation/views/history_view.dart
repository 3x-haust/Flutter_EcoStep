import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/features/history/presentation/viewmodels/history_viewmodel.dart';
import 'package:eco_step/features/history/presentation/widgets/history_item_widget.dart';
import 'package:eco_step/features/history/presentation/widgets/history_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    final viewModel = Get.find<HistoryViewModel>();

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Text(
                '기록',
                style: Typo.titleStrong(context, color: colors.gray900),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (viewModel.isLoading) {
                  return const SingleChildScrollView(
                    child: HistorySkeleton(),
                  );
                }

                if (viewModel.errorMessage.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          viewModel.errorMessage,
                          style: Typo.bodyRegular(context, color: colors.gray900),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => viewModel.loadHistoryItems(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                          ),
                          child: const Text('다시 시도'),
                        ),
                      ],
                    ),
                  );
                }

                if (viewModel.historyItems.isEmpty) {
                  return Center(
                    child: Text(
                      '기록이 없습니다.',
                      style: Typo.bodyRegular(context, color: colors.gray900),
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: viewModel.historyItems.map((item) {
                      final isExpanded = viewModel.isItemExpanded(item.id);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: HistoryItemWidget(
                          item: item,
                          formattedDate: viewModel.formatDate(item.createdAt),
                          isExpanded: isExpanded,
                          onTap: () => viewModel.onHistoryItemTap(item),
                          onMoreTap: isExpanded 
                              ? () => viewModel.onMoreButtonTap(item)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}