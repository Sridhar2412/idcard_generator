import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/core/theme/app_color.dart';
import 'package:id_card_generator_app/presentation/pages/mapping_page.dart';
import 'package:id_card_generator_app/presentation/pages/review_page.dart';
import 'package:id_card_generator_app/presentation/pages/upload_page.dart';

final pageIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final index = ref.watch(pageIndexProvider);
    final pages = [
      UploadStep(
          onNext: () =>
              ref.read(pageIndexProvider.notifier).update((state) => 1)),
      MappingStep(
          onNext: () =>
              ref.read(pageIndexProvider.notifier).update((state) => 2),
          onBack: () =>
              ref.read(pageIndexProvider.notifier).update((state) => 0)),
      ReviewGenerateStep(
          onBack: () =>
              ref.read(pageIndexProvider.notifier).update((state) => 1)),
    ];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.primary,
          centerTitle: true,
          leading: index == 0
              ? null
              : IconButton(
                  onPressed: () => ref
                      .read(pageIndexProvider.notifier)
                      .update((state) => state - 1),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                    color: AppColor.white,
                  ),
                ),
          title: const Text(
            'ID Card Generator',
            style: TextStyle(fontSize: 16, color: AppColor.white),
          )),
      body: pages[index],
    );
  }
}
