import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/core/theme/app_color.dart';

import '../providers/excel_provider.dart';
import '../providers/template_provider.dart';

class UploadStep extends ConsumerWidget {
  const UploadStep({super.key, required this.onNext});
  final VoidCallback onNext;

  Future<void> _pickTemplate(WidgetRef ref) async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
      withData: true,
    );
    final file = res?.files.first;
    if (file == null) return;
    await ref
        .read(templateProvider.notifier)
        .load(path: file.path, bytes: file.bytes);
  }

  Future<void> _pickExcel(WidgetRef ref) async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      withData: true,
    );
    final file = res?.files.first;
    if (file?.bytes == null) return;
    await ref.read(excelDataProvider.notifier).parse(file!.bytes!);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final template = ref.watch(templateProvider);
    final excel = ref.watch(excelDataProvider);
    final ready = template.hasValue &&
        template.value != null &&
        excel.hasValue &&
        excel.value != null;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Row(children: [
          //   ElevatedButton(
          //       onPressed: () => _pickTemplate(ref),
          //       child: const Text('Upload Template')),
          //   const SizedBox(width: 12),
          //   ElevatedButton(
          //       onPressed: () => _pickExcel(ref),
          //       child: const Text('Upload Excel')),
          // ]),
          // const SizedBox(height: 16),
          // Text(
          //     'Template: ${template.hasValue && template.value != null ? "Loaded" : "Not loaded"}'),
          // Text(
          //     'Excel: ${excel.hasValue && excel.value != null ? "Loaded" : "Not loaded"}'),

          Stack(
            children: [
              InkWell(
                onTap: () => _pickTemplate(ref),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      color: template.hasValue && template.value != null
                          ? AppColor.green
                          : AppColor.primary,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 150,
                          color: AppColor.white,
                        ),
                        Text(
                          'Upload Template',
                          style: TextStyle(fontSize: 14, color: AppColor.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (template.hasValue && template.value != null)
                Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () {
                      ref.refresh(templateProvider);
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: AppColor.white,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              InkWell(
                onTap: () => _pickExcel(ref),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      color: excel.hasValue && excel.value != null
                          ? AppColor.green
                          : AppColor.primary,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.document_scanner,
                          size: 130,
                          color: AppColor.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Upload Excel',
                          style: TextStyle(fontSize: 14, color: AppColor.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (excel.hasValue && excel.value != null)
                Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () {
                      ref.refresh(excelDataProvider);
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: AppColor.white,
                    ),
                  ),
                )
            ],
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: ready ? onNext : null, child: const Text('Next')),
        ],
      ),
    );
  }
}
