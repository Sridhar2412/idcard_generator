import 'package:flutter/material.dart';
import 'package:id_card_generator_app/core/theme/app_color.dart';
import 'package:id_card_generator_app/presentation/pages/mapping_page.dart';
import 'package:id_card_generator_app/presentation/pages/review_page.dart';
import 'package:id_card_generator_app/presentation/pages/upload_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      UploadStep(onNext: () => setState(() => index = 1)),
      MappingStep(
          onNext: () => setState(() => index = 2),
          onBack: () => setState(() => index = 0)),
      ReviewGenerateStep(onBack: () => setState(() => index = 1)),
    ];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.primary,
          centerTitle: true,
          title: const Text(
            'ID Card Generator',
            style: TextStyle(fontSize: 16, color: AppColor.white),
          )),
      body: pages[index],
    );
  }
}
