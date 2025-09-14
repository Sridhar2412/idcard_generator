import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:id_card_generator_app/domain/models/template_field_model.dart';
import 'package:id_card_generator_app/presentation/components/card_widget.dart';

class CardCaptureHost extends StatefulWidget {
  const CardCaptureHost({
    super.key,
    required this.template,
    required this.templateSize,
    required this.fields,
    required this.valuesListenable,
  });

  final ImageProvider template;
  final Size templateSize;
  final List<TemplateField> fields;
  final ValueListenable<Map<String, String>> valuesListenable;

  @override
  CardCaptureHostState createState() => CardCaptureHostState();
}

class CardCaptureHostState extends State<CardCaptureHost> {
  final _repaintKey = GlobalKey();

  Future<Uint8List> capture({double pixelRatio = 3.0}) async {
    await WidgetsBinding.instance.endOfFrame;
    final boundary =
        _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: pixelRatio);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _repaintKey,
      child: ValueListenableBuilder<Map<String, String>>(
        valueListenable: widget.valuesListenable,
        builder: (context, valuesByFieldId, _) {
          return SizedBox(
            width: widget.templateSize.width,
            height: widget.templateSize.height,
            child: SingleCardWidget(
              template: widget.template,
              templateSize: widget.templateSize,
              valuesByFieldId: valuesByFieldId,
              fields: widget.fields,
            ),
          );
        },
      ),
    );
  }
}
