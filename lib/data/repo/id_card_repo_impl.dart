// import 'package:dartz/dartz.dart';
import 'dart:typed_data';

import 'package:id_card_generator_app/data/source/photo_source.dart';
import 'package:id_card_generator_app/domain/repositories/id_card_repo.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class IdCardsRepositoryImpl implements IdCardsRepository {
  IdCardsRepositoryImpl({required this.source});

  final PhotoSource source;

  @override
  Future<(List<String>, List<Map<String, String>>)> parseExcel(
      Uint8List xlsxBytes) {
    return source.excelParse(xlsxBytes);
  }

  @override
  Future<(Uint8List, double, double)> loadTemplateBytes(String path,
      {Uint8List? bytes}) async {
    if (bytes != null) return source.templateFromBytes(bytes);
    return source.templateFromPath(path);
  }

  @override
  Future<Uint8List> buildPdfFromCards(List<Uint8List> cardPngs) async {
    final doc = pw.Document();
    final imgs = cardPngs.map((b) => pw.MemoryImage(b)).toList();
    doc.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (ctx) {
          return [
            pw.Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final i in imgs)
                  pw.Image(i, width: (PdfPageFormat.a4.availableWidth - 8) / 2)
              ],
            ),
          ];
        }));
    return doc.save();
  }
}
