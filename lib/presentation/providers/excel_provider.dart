import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/data/helper/dio_instance.dart';
import 'package:id_card_generator_app/data/repo/id_card_repo_impl.dart';
import 'package:id_card_generator_app/data/source/photo_source.dart';
import 'package:id_card_generator_app/presentation/pages/usecases/parse_excel.dart';

final parseExcelUseCaseProvider = Provider<ParseExcelUseCase>((ref) {
  final repo = ref.watch(idCardsRepositoryProvider);
  return ParseExcelUseCase(repo);
});

final excelDataProvider = AsyncNotifierProvider<ExcelDataNotifier,
    (List<String>, List<Map<String, String>>)?>(() {
  return ExcelDataNotifier();
});

class ExcelDataNotifier
    extends AsyncNotifier<(List<String>, List<Map<String, String>>)?> {
  @override
  Future<(List<String>, List<Map<String, String>>)?> build() async => null;

  Future<void> parse(Uint8List bytes) async {
    state = const AsyncLoading();
    final usecase = ref.read(parseExcelUseCaseProvider);
    state = await AsyncValue.guard(() => usecase.call(bytes));
  }

  void clear() => state = const AsyncData(null);
}

final idCardsRepositoryProvider = Provider((ref) {
  return IdCardsRepositoryImpl(
      source: PhotoSource(ref.read(dioInstanceProvider)));
});
