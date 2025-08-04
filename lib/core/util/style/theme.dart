import 'package:flutter/material.dart';
import 'package:eco_step/gen/fonts.gen.dart';

ThemeData initThemeData({required Brightness brightness}) {
  if (brightness == Brightness.light) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: FontFamily.pretendard
    );
  } else {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: FontFamily.pretendard,
    );
  }
}