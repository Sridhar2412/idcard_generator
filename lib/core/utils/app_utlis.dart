import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:id_card_generator_app/domain/models/template_field_model.dart';
import 'package:id_card_generator_app/presentation/components/card_capture.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AppUtlis {
  static ({List<String> columns, List<List<dynamic>> rows}) decode(
      Uint8List bytes) {
    final excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables[excel.tables.keys.first]!;
    final header = sheet.rows.first
        .map((c) => (c?.value?.toString() ?? '').trim())
        .toList();
    final data = sheet.rows
        .skip(1)
        .map((r) => r.map((c) => (c?.value?.toString() ?? '').trim()).toList())
        .toList();
    return (columns: header, rows: data);
  }

  static Future<Uint8List> buildGridPdf({
    required List<Uint8List> cardPngs,
    PdfPageFormat format = PdfPageFormat.a4,
    int columns = 2,
    double spacing = 8,
  }) async {
    final doc = pw.Document();

    for (final bytes in cardPngs) {
      final img = pw.MemoryImage(bytes);
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (_) => pw.Center(
            child: pw.Image(img, fit: pw.BoxFit.contain),
          ),
        ),
      );
    }
    return await doc.save();
  }

  static Future<(double width, double height)> decodeImageSize(
      Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return (frame.image.width.toDouble(), frame.image.height.toDouble());
  }

  static Future<List<Uint8List>> renderAll({
    required BuildContext context,
    required ImageProvider template,
    required Size templateSize,
    required List<Map<String, String>> rows, // header -> value
    required List<TemplateField> fields,
    double pixelRatio = 3.0,
  }) async {
    final results = <Uint8List>[];
    final currentRow = ValueNotifier<Map<String, String>>(<String, String>{});
    final hostKey = GlobalKey<CardCaptureHostState>();

    await precacheImage(template, context, size: templateSize);
    await WidgetsBinding.instance.endOfFrame;
    print(fields);
    final entry = OverlayEntry(
      builder: (_) => Offstage(
        offstage: false,
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: CardCaptureHost(
              key: hostKey,
              template: template,
              templateSize: templateSize,
              fields: fields,
              valuesListenable: currentRow,
            ),
          ),
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(entry);
    await WidgetsBinding.instance.endOfFrame;

    try {
      for (final row in rows) {
        final enriched = <String, String>{...row};

        final normalized = <String, String>{};
        for (final e in row.entries) {
          final lower = e.key.trim().toLowerCase();
          final val = e.value.trim();
          normalized[lower] = val;
          normalized[lower.replaceAll(RegExp(r'\s+'), '')] = val;
        }

        for (final f in fields) {
          final hOrig = f.excelColumn.trim();
          final hLower = hOrig.toLowerCase();
          final hNoSpace = hLower.replaceAll(RegExp(r'\s+'), '');
          final v = normalized[hLower] ?? normalized[hNoSpace] ?? '';

          enriched[f.id] = v;
          enriched[hOrig] = v;
          enriched[hLower] = v;
          enriched[hNoSpace] = v;
        }

        currentRow.value = enriched;
        await WidgetsBinding.instance.endOfFrame;
        final bytes =
            await hostKey.currentState!.capture(pixelRatio: pixelRatio);
        results.add(bytes);
      }
    } finally {
      entry.remove();
      currentRow.dispose();
    }
    return results;
  }
}
