import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/presentation/pages/usecases/build_pdf.dart';
import 'package:id_card_generator_app/presentation/providers/excel_provider.dart';

final buildPdfUseCaseProvider = Provider<BuildPdfUseCase>((ref) {
  final repo = ref.watch(idCardsRepositoryProvider);
  return BuildPdfUseCase(repo);
});

final pdfBytesProvider = AsyncNotifierProvider<PdfBytesNotifier, Uint8List?>(
    () => PdfBytesNotifier());

class PdfBytesNotifier extends AsyncNotifier<Uint8List?> {
  @override
  Future<Uint8List?> build() async => null;

  Future<void> generate(List<Uint8List> cardPngs) async {
    state = const AsyncLoading();
    final usecase = ref.read(buildPdfUseCaseProvider);
    state = await AsyncValue.guard(() => usecase.call(cardPngs));
  }

  void clear() => state = const AsyncData(null);
}
