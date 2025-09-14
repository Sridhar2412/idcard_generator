import 'package:flutter/material.dart';
import 'package:id_card_generator_app/core/theme/app_theme.dart';
import 'package:id_card_generator_app/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ID Card Generator',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
