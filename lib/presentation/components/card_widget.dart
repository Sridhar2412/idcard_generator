import 'package:flutter/material.dart';
import 'package:id_card_generator_app/domain/models/field_type.dart';
import 'package:id_card_generator_app/domain/models/template_field_model.dart';

class SingleCardWidget extends StatelessWidget {
  final ImageProvider template;
  final Size templateSize;
  final Map<String, String> row;
  final List<TemplateField> fields;

  const SingleCardWidget(
      {super.key,
      required this.template,
      required this.templateSize,
      required this.row,
      required this.fields});

  @override
  Widget build(BuildContext context) {
    // Build a case-insensitive map
    final normalized = <String, String>{
      for (final e in row.entries) e.key.trim().toLowerCase(): e.value
    };
    String valueOf(String header) =>
        normalized[header.trim().toLowerCase()] ?? '';

    return SizedBox(
      width: templateSize.width,
      height: templateSize.height / 2,
      child: Stack(
        children: [
          Positioned.fill(
              child: Image(
                  image: template,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high)),
          for (final f in fields)
            Positioned(
              left: f.x * templateSize.width,
              top: f.y * templateSize.height * 3.19,
              width: (f.width * templateSize.width).clamp(1, double.infinity),
              height:
                  (f.height * templateSize.height).clamp(1, double.infinity),
              child: _buildField(f, valueOf(f.excelColumn)),
            ),
        ],
      ),
    );
  }

  Widget _buildField(TemplateField f, String value) {
    switch (f.type) {
      case FieldType.text:
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            textAlign: f.align ?? TextAlign.left,
            style: TextStyle(
              fontSize: f.fontSize ?? 13,
              color: const Color(0xFF000000),
              fontFamily: f.fontFamily,
            ),
          ),
        );
      case FieldType.photo:
        return value.isEmpty
            ? DecoratedBox(decoration: BoxDecoration(border: Border.all()))
            : Image.network(value, fit: BoxFit.cover);
      case FieldType.qr:
        return const SizedBox.shrink();
    }
  }
}
