import 'package:flutter/material.dart';
import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Text(
          'Home Screen',
          style: Typo.titleStrong(context),
        ),
      ),
    );
  }
}