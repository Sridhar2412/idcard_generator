import 'dart:typed_data';

import 'package:id_card_generator_app/domain/repositories/id_card_repo.dart';

class ParseExcelUseCase {
  final IdCardsRepository repo;
  ParseExcelUseCase(this.repo);
  Future<(List<String>, List<Map<String, String>>)> call(Uint8List bytes) =>
      repo.parseExcel(bytes);
}
