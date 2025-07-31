import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/features/history/domain/entities/history_item.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HistoryItemWidget extends StatelessWidget {
  final HistoryItem item;
  final VoidCallback onTap;
  final VoidCallback? onMoreTap;
  final String formattedDate;
  final bool isExpanded;

  const HistoryItemWidget({
    super.key,
    required this.item,
    required this.onTap,
    required this.formattedDate,
    required this.isExpanded,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    if (isExpanded) {
      return _buildExpandedItem(context, colors);
    } else {
      return _buildNormalItem(context, colors);
    }
  }

  Widget _buildExpandedItem(BuildContext context, ThemeColors colors) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colors.gray10,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: colors.gray30,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.icons.step.path,
                      colorFilter: ColorFilter.mode(
                        colors.primary,
                        BlendMode.srcIn,
                      ),
                      width: 16,
                      height: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            item.title,
                            style: Typo.bodyRegular(
                              context,
                              color: colors.gray900,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (item.isToday)
                            Text(
                              '오늘',
                              style: Typo.captionRegular(
                                context,
                                color: colors.primary,
                              ),
                            ),
                          const Spacer(),
                          GestureDetector(
                            onTap: onMoreTap,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '더보기',
                                  style: Typo.labelStrong(
                                    context,
                                    color: colors.gray60,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  Assets.icons.arrowForward.path,
                                  colorFilter: ColorFilter.mode(
                                    colors.gray60,
                                    BlendMode.srcIn,
                                  ),
                                  width: 9,
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        formattedDate,
                        style: Typo.captionRegular(
                          context,
                          color: colors.gray300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 44),
              child: Container(
              width: 138,
              height: 138,
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: colors.primary, width: 1.5),
              ),
              child: item.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        item.imageUrl!,
                        width: 138,
                        height: 138,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: colors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.image,
                                color: colors.primary,
                                size: 40,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: colors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 138,
                      height: 138,
                    ),
            )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalItem(BuildContext context, ThemeColors colors) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colors.gray10,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: colors.gray30,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.icons.step.path,
                  colorFilter: ColorFilter.mode(
                    colors.primary,
                    BlendMode.srcIn,
                  ),
                  width: 16,
                  height: 18,
                ),
              ),
            ),
            const SizedBox(width: 19),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Typo.bodyRegular(context, color: colors.gray900),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formattedDate,
                    style: Typo.captionRegular(context, color: colors.gray300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
