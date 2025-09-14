import 'package:flutter/material.dart';
import 'package:id_card_generator_app/domain/models/template_field_model.dart';

class TemplateCanvas extends StatelessWidget {
  final ImageProvider templateImage;
  final Size templateSize;
  final List<TemplateField> fields;
  final void Function(String id, Rect newRect) onFieldMoved;

  const TemplateCanvas({
    super.key,
    required this.templateImage,
    required this.templateSize,
    required this.fields,
    required this.onFieldMoved,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 0.2,
      maxScale: 8,
      child: SizedBox(
        width: templateSize.width,
        height: templateSize.height,
        child: Stack(
          children: [
            Positioned.fill(
                child: Image(image: templateImage, fit: BoxFit.contain)),
            for (final f in fields)
              Positioned(
                left: f.x * templateSize.width,
                top: f.y * templateSize.height,
                width: f.width * templateSize.width,
                height: f.height * templateSize.height,
                child: FieldHandle(
                  id: f.id,
                  onMoved: onFieldMoved,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 2),
                      color: Colors.blueAccent.withOpacity(0.1),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(f.excelColumn,
                            style: const TextStyle(fontSize: 12)),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FieldHandle extends StatefulWidget {
  final String id;
  final Widget child;
  final void Function(String id, Rect rect) onMoved;
  const FieldHandle(
      {super.key,
      required this.id,
      required this.child,
      required this.onMoved});
  @override
  State<FieldHandle> createState() => _FieldHandleState();
}

class _FieldHandleState extends State<FieldHandle> {
  late Offset pos;
  late Size size;

  @override
  void initState() {
    super.initState();
    pos = Offset.zero;
    size = Size.zero;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      if (size == Size.zero) size = Size(c.maxWidth, c.maxHeight);
      return GestureDetector(
        onPanUpdate: (d) {
          setState(() {
            pos += d.delta;
          });
          final box = context.findRenderObject() as RenderBox;
          final topLeft = box.localToGlobal(Offset.zero) + pos;
          widget.onMoved(widget.id,
              Rect.fromLTWH(pos.dx, pos.dy, size.width, size.height));
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            widget.child,
            Positioned(
              right: -6,
              bottom: -6,
              child: GestureDetector(
                onPanUpdate: (d) {
                  setState(() => size += Offset(d.delta.dx, d.delta.dy));
                  widget.onMoved(widget.id,
                      Rect.fromLTWH(pos.dx, pos.dy, size.width, size.height));
                },
                child: const Icon(Icons.open_in_full, size: 16),
              ),
            ),
          ],
        ),
      );
    });
  }
}
