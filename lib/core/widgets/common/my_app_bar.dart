import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int streakCount;
  final DateTime? lastCompletedDate;

  const MyAppBar({super.key, this.streakCount = 0, this.lastCompletedDate});

  @override
  Widget build(BuildContext context) {
    final currentStreak = _calculateCurrentStreak();
    final isFireActive = currentStreak > 0;
    final colors = ThemeColors.of(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Eco\nStep',
              style: TextStyle(
                fontFamily: 'ClimateCrisis',
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: colors.gray900,
                height: 1.0,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(
              width: 47,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    isFireActive
                        ? Assets.icons.fireOn.path
                        : Assets.icons.fireOff.path,
                    width: 26,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      isFireActive ? colors.gray900 : colors.gray50,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    currentStreak.toString(),
                    style: Typo.titleStrong(
                      context,
                      color: isFireActive ? colors.gray900 : colors.gray50,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateCurrentStreak() {
    if (lastCompletedDate == null) return 0;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastCompleted = DateTime(
      lastCompletedDate!.year,
      lastCompletedDate!.month,
      lastCompletedDate!.day,
    );

    final daysDifference = today.difference(lastCompleted).inDays;

    if (daysDifference == 0) {
      return streakCount;
    } else if (daysDifference == 1) {
      return streakCount;
    } else {
      return 0;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
