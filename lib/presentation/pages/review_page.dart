import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/presentation/providers/genration_provider.dart';
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
              onPressed: () async {
                // In a full app, gather card PNGs from preview captures and pass here.
                await ref
                    .read(pdfBytesProvider.notifier)
                    .generate(const <Uint8List>[]);
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
