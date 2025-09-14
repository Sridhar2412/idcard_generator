import 'package:flutter/material.dart';
import 'package:id_card_generator_app/core/theme/app_color.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
