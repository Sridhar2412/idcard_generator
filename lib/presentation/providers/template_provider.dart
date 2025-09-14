import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/presentation/pages/usecases/load_template.dart';
import 'package:id_card_generator_app/presentation/providers/excel_provider.dart';

final loadTemplateUseCaseProvider = Provider<LoadTemplateUseCase>((ref) {
  final repo = ref.watch(idCardsRepositoryProvider);
  return LoadTemplateUseCase(repo);
});

final templateProvider =
    AsyncNotifierProvider<TemplateNotifier, (Uint8List, double, double)?>(() {
  return TemplateNotifier();
});

class TemplateNotifier extends AsyncNotifier<(Uint8List, double, double)?> {
  @override
  Future<(Uint8List, double, double)?> build() async => null;

  Future<void> load({String? path, Uint8List? bytes}) async {
    state = const AsyncLoading();
    final usecase = ref.read(loadTemplateUseCaseProvider);
    state = await AsyncValue.guard(() => usecase.call(path, bytes: bytes));
  }

  void clear() => state = const AsyncData(null);
}
