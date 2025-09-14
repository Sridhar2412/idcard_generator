import 'package:flutter/material.dart';
import 'package:id_card_generator_app/domain/models/template_field_model.dart';

class SingleCardWidget extends StatelessWidget {
  final ImageProvider template;
  final Size templateSize;
  final Map<String, String> valuesByFieldId;
  final List<TemplateField> fields;

  const SingleCardWidget({
    super.key,
    required this.template,
    required this.templateSize,
    required this.valuesByFieldId,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: templateSize.width,
      height: templateSize.height,
      child: Stack(
        children: [
          Positioned.fill(
              child: Image(
                  image: template,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high)),
          Positioned(
            top: templateSize.width * 0.226,
            left: templateSize.width * 0.14,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (final f in fields)
                Positioned(
                  left: f.x * templateSize.width,
                  top: f.y * templateSize.height,
                  width: f.width * templateSize.width,
                  height: f.height * templateSize.height,
                  child: Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Text(
                        valuesByFieldId[f.id] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: f.align ?? TextAlign.left,
                        style: TextStyle(
                          fontSize: (14).toDouble(),
                          color: const Color(0xFF000000),
                          fontFamily: f.fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
            ]),
          )
        ],
      ),
    );
  }
}
