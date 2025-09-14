import 'dart:io';
import 'dart:typed_data';

import 'package:id_card_generator_app/core/utils/app_utlis.dart';

class TemplateLocalDataSource {
  Future<(Uint8List bytes, double width, double height)> fromPath(
      String path) async {
    final bytes = await File(path).readAsBytes();
    final (w, h) = await AppUtlis.decodeImageSize(bytes);
    return (bytes, w, h);
  }

  Future<(Uint8List bytes, double width, double height)> fromBytes(
      Uint8List bytes) async {
    final (w, h) = await AppUtlis.decodeImageSize(bytes);
    return (bytes, w, h);
  }
}
