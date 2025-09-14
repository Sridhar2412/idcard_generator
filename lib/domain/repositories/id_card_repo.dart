import 'dart:typed_data';

abstract class IdCardsRepository {
  Future<(List<String> columns, List<Map<String, String>> rows)> parseExcel(
      Uint8List xlsxBytes);
  Future<(Uint8List bytes, double widthPx, double heightPx)> loadTemplateBytes(
      String path,
      {Uint8List? bytes});
  Future<Uint8List> buildPdfFromCards(List<Uint8List> cardPngs);
}
