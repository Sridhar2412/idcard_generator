import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/core/utils/app_utlis.dart';
import 'package:id_card_generator_app/presentation/providers/excel_provider.dart';
import 'package:id_card_generator_app/presentation/providers/genration_provider.dart';
import 'package:id_card_generator_app/presentation/providers/mapped_filed_provider.dart';
import 'package:id_card_generator_app/presentation/providers/template_provider.dart';
import 'package:printing/printing.dart';

class ReviewGenerateStep extends ConsumerWidget {
  const ReviewGenerateStep({super.key, required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfState = ref.watch(pdfBytesProvider);
    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Reset AsyncValue<Uint8List?> to null so PdfPreview disappears
                ref.read(pdfBytesProvider.notifier).clear();
              },
              child: const Text('Clear PDF'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                // Read inputs
                final templateTuple =
                    ref.read(templateProvider).value; // (bytes, w, h)
                final excelTuple =
                    ref.read(excelDataProvider).value; // (columns, rows)
                final fields =
                    ref.read(mappedFieldsProvider); // List<TemplateField>
                if (templateTuple == null ||
                    excelTuple == null ||
                    fields.isEmpty) return;

                final templateBytes = templateTuple.$1;
                final templateSize = Size(templateTuple.$2, templateTuple.$3);

                // Ensure rows are header->value maps
                final headers = excelTuple.$1; // List<String>
                final raw = excelTuple
                    .$2; // List<List<dynamic>> OR List<Map<String,String>>
                final List<Map<String, String>> rows = raw.isNotEmpty
                    ? List<Map<String, String>>.from(raw as List)
                    : <Map<String, String>>[
                        for (final r in raw as List<List<dynamic>>)
                          {
                            for (int i = 0;
                                i < headers.length && i < r.length;
                                i++)
                              headers[i].trim(): (r[i] ?? '').toString().trim(),
                          },
                      ];

                // Render all cards to PNG images
                final cardPngs = await AppUtlis.renderAll(
                  context: context,
                  template: MemoryImage(templateBytes),
                  templateSize: templateSize,
                  rows: rows,
                  fields: fields,
                  pixelRatio: 3.0,
                );

                if (cardPngs.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('No cards captured; check mapping')),
                  );
                  return;
                }

                // Generate and publish PDF via AsyncNotifier so the preview rebuilds
                await ref.read(pdfBytesProvider.notifier).generate(cardPngs);
              },
              child: const Text('Generate PDF'),
            ),
          ],
        ),
        const Divider(),
        Expanded(
          child: pdfState.hasValue && pdfState.value != null
              ? PdfPreview(build: (fmt) async => pdfState.value!)
              : const Center(child: Text('Generate to preview PDF')),
        ),
      ],
    );
  }
}
