import 'dart:typed_data';

import 'package:id_card_generator_app/domain/repositories/id_card_repo.dart';

class LoadTemplateUseCase {
  final IdCardsRepository repo;
  LoadTemplateUseCase(this.repo);
  Future<(Uint8List, double, double)> call(String? path,
      {Uint8List? bytes}) async {
    if (path == null && bytes == null) {
      throw ArgumentError('Provide either path or bytes');
    }
    return repo.loadTemplateBytes(path ?? '', bytes: bytes);
  }
}
