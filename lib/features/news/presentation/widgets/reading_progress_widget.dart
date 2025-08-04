import 'package:eco_step/core/util/style/colors.dart';
import 'package:flutter/material.dart';

class ReadingProgressWidget extends StatelessWidget {
  final double progress;

  const ReadingProgressWidget({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Container(
      height: 2.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.gray30,
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: colors.primary,
          ),
        ),
      ),
    );
  }
}
