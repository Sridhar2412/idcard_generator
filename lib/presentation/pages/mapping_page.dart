import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/core/theme/app_color.dart';
import 'package:id_card_generator_app/domain/models/field_type.dart';
import 'package:id_card_generator_app/domain/models/template_field_model.dart';
import 'package:id_card_generator_app/presentation/components/custom_filled_button.dart';
import 'package:id_card_generator_app/presentation/components/template_canvas_widget.dart';
import 'package:id_card_generator_app/presentation/providers/mapped_filed_provider.dart';

import '../providers/excel_provider.dart';
import '../providers/template_provider.dart';

final fieldTypeProvider = StateProvider<FieldType>((ref) {
  return FieldType.text;
});

class MappingStep extends ConsumerStatefulWidget {
  const MappingStep({super.key, required this.onNext, required this.onBack});
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  ConsumerState<MappingStep> createState() => _MappingStepState();
}

class _MappingStepState extends ConsumerState<MappingStep> {
  final fields = <TemplateField>[];

  void _addField(FieldType type, String excelColumn) {
    setState(() {
      fields.add(TemplateField(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        excelColumn: excelColumn,
        x: 0.1,
        y: 0.1,
        width: 0.1,
        height: 0.04,
        fontSize: 16,
        color: AppColor.primary.value,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final template = ref.watch(templateProvider).value;
    final excel = ref.watch(excelDataProvider).value;
    if (template == null || excel == null) {
      return Center(
          child: TextButton(
              onPressed: widget.onBack,
              child: const Text('Go back and upload inputs')));
    }
    final (bytes, w, h) = template;
    final columns = excel.$1;

    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 16),
            DropdownButton<FieldType>(
              value: ref.watch(fieldTypeProvider),
              items: const [
                DropdownMenuItem(value: FieldType.text, child: Text('Text')),
                DropdownMenuItem(value: FieldType.photo, child: Text('Photo')),
              ],
              onChanged: (val) {
                ref.read(fieldTypeProvider.notifier).state =
                    val ?? FieldType.text;
              },
            ),
            const SizedBox(width: 12),
            const Spacer(),
            DropdownButton<String>(
              hint: const Text('Select Excel column'),
              items: [
                for (final c in columns)
                  DropdownMenuItem(value: c, child: Text(c))
              ],
              onChanged: (col) {
                if (col != null) _addField(ref.watch(fieldTypeProvider), col);
              },
            ),
            const Spacer(),
          ],
        ),
        const Divider(),
        Expanded(
          child: TemplateCanvas(
            templateImage: MemoryImage(bytes),
            templateSize: Size(w, h),
            fields: fields,
            onFieldMoved: (id, rect) {
              final i = fields.indexWhere((f) => f.id == id);
              if (i == -1) return;
              setState(() {
                fields[i] = fields[i].copyWith(
                  x: rect.left / w,
                  y: rect.top / h,
                  width: rect.width / w,
                  height: rect.height / h,
                );
              });
              print('Field moved: $fields');
            },
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Expanded(
            child: CustomFilledButton(
              size: Size(MediaQuery.of(context).size.width, 50),
              onTap: () {
                ref
                    .read(mappedFieldsProvider.notifier)
                    .setAll(List<TemplateField>.from(fields));
                widget.onNext();
              },
              title: 'Next',
            ),
          ),
        ),
      ],
    );
  }
}
