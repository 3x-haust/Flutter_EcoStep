import 'package:flutter/material.dart';

ThemeData initThemeData({required Brightness brightness}) {
  if (brightness == Brightness.light) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Pretendard',
    );
  } else {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Pretendard'
    );
  }
}