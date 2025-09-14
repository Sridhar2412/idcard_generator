import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/core/utils/app_utlis.dart';
import 'package:id_card_generator_app/presentation/providers/genration_provider.dart';
import 'package:id_card_generator_app/presentation/providers/mapped_filed_provider.dart';
import 'package:printing/printing.dart';

import '../providers/excel_provider.dart';
import '../providers/template_provider.dart';

class ReviewGenerateStep extends ConsumerWidget {
  const ReviewGenerateStep({super.key, required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfState = ref.watch(pdfBytesProvider);

    Future<void> generate() async {
      final templateTuple = ref.read(templateProvider).value;
      final excelTuple = ref.read(excelDataProvider).value;
      final fields = ref.read(mappedFieldsProvider);
      if (templateTuple == null || excelTuple == null || fields.isEmpty) return;

      final templateBytes = templateTuple.$1;
      final templateSize = Size(templateTuple.$2, templateTuple.$3);
      final rows = excelTuple.$2;

      // Optional: precache network images for photo fields per row before capture
      // await _precacheRowPhotos(rows, fields, context); // see Image.network doc [23]

      final cardPngs = await AppUtlis.renderAll(
        context: context,
        template: MemoryImage(templateBytes),
        templateSize: templateSize,
        rows: rows, // List<Map<String,String>>
        fields: fields, // List<TemplateField> with excelColumn set
        pixelRatio: 3.0,
      );

      final bytes = await AppUtlis.buildGridPdf(cardPngs: cardPngs);
      await ref
          .read(pdfBytesProvider.notifier)
          .generate(cardPngs); // or generate(...) wrapper
    }

    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
            const Spacer(),
            TextButton(
              onPressed: () => ref.read(pdfBytesProvider.notifier).clear(),
              child: const Text('Clear'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
                onPressed: generate, child: const Text('Generate PDF')),
          ],
        ),
        const Divider(),
        Expanded(
          child: pdfState.hasValue && pdfState.value != null
              ? PdfPreview(
                  build: (fmt) async => pdfState.value!,
                  allowPrinting: false,
                  allowSharing: false,
                  canChangePageFormat: false,
                  canChangeOrientation: false,
                  canDebug: false,
                  useActions: false,
                  maxPageWidth: 800,
                )
              : const Center(child: Text('Generate to preview PDF')),
        ),
      ],
    );
  }
}
