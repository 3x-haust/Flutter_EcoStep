import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Container(
      height: 136,
      decoration: BoxDecoration(
        color: colors.gray20,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(
              context,
              index: 0,
              iconPath: Assets.icons.home.path,
              label: 'Home',
              isSelected: widget.currentIndex == 0,
            ),
            _buildNavItem(
              context,
              index: 1,
              iconPath: Assets.icons.map.path,
              label: 'Map',
              isSelected: widget.currentIndex == 1,
            ),
            _buildNavItem(
              context,
              index: 2,
              iconPath: Assets.icons.history.path,
              label: 'History',
              isSelected: widget.currentIndex == 2,
            ),
            _buildNavItem(
              context,
              index: 3,
              iconPath: Assets.icons.profile.path,
              label: 'Profile',
              isSelected: widget.currentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required String iconPath,
    required String label,
    required bool isSelected,
  }) {
    final colors = ThemeColors.of(context);
    final color = isSelected ? colors.primary : colors.gray90;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,
              height: 30,
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  color,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: isSelected
                  ? Typo.bodyStrong(context, color: color)
                  : Typo.bodyRegular(context, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
