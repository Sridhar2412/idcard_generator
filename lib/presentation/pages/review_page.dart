import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/core/utils/app_utlis.dart';
import 'package:id_card_generator_app/presentation/components/custom_filled_button.dart';
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
        const Divider(),
        Expanded(
          child: pdfState.hasValue && pdfState.value != null
              ? PdfPreview(build: (fmt) async => pdfState.value!)
              : const Center(child: Text('Generate to preview PDF')),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: CustomFilledButton.secondary(
                    size: Size(MediaQuery.of(context).size.width, 50),
                    onTap: () {
                      ref.read(pdfBytesProvider.notifier).clear();
                    },
                    title: 'Clear PDF'),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: CustomFilledButton(
                  size: Size(MediaQuery.of(context).size.width, 50),
                  onTap: () async {
                    // Read inputs
                    final templateTuple = ref.read(templateProvider).value;
                    final excelTuple = ref.read(excelDataProvider).value;
                    final fields = ref.watch(mappedFieldsProvider);
                    if (templateTuple == null ||
                        excelTuple == null ||
                        fields.isEmpty) return;

                    final templateBytes = templateTuple.$1;
                    final templateSize =
                        Size(templateTuple.$2, templateTuple.$3);

                    final headers = excelTuple.$1;
                    final raw = excelTuple.$2;
                    final List<Map<String, String>> rows = raw.isNotEmpty
                        ? List<Map<String, String>>.from(raw as List)
                        : <Map<String, String>>[
                            for (final r in raw as List<List<dynamic>>)
                              {
                                for (int i = 0;
                                    i < headers.length && i < r.length;
                                    i++)
                                  headers[i].trim():
                                      (r[i] ?? '').toString().trim(),
                              },
                          ];

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

                    await ref
                        .read(pdfBytesProvider.notifier)
                        .generate(cardPngs);
                  },
                  title: 'Generate PDF',
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
