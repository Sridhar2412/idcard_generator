import 'dart:typed_data';

import 'package:id_card_generator_app/domain/repositories/id_card_repo.dart';

class BuildPdfUseCase {
  final IdCardsRepository repo;
  BuildPdfUseCase(this.repo);
  Future<Uint8List> call(List<Uint8List> cardPngs) =>
      repo.buildPdfFromCards(cardPngs);
}
