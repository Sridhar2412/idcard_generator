import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:id_card_generator_app/domain/models/template_field_model.dart';

class TemplateCanvas extends StatefulWidget {
  final ImageProvider templateImage;
  final Size templateSize; // original px (w, h) of the template image
  final List<TemplateField> fields; // normalized [0..1] x,y,width,height
  final void Function(String id, Rect newRectNorm) onFieldMoved;

  const TemplateCanvas({
    super.key,
    required this.templateImage,
    required this.templateSize,
    required this.fields,
    required this.onFieldMoved,
  });

  @override
  State<TemplateCanvas> createState() => _TemplateCanvasState();
}

class _TemplateCanvasState extends State<TemplateCanvas> {
  final _tc = TransformationController();

  // Convert global position to scene (child) coordinates
  Offset _toScene(Offset globalPosition) => _tc.toScene(globalPosition); // [22]

  void _saveRect(String id, Rect sceneRect) {
    final w = widget.templateSize.width;
    final h = widget.templateSize.height;
    // Clamp to template bounds and normalize
    final clamped = Rect.fromLTWH(
      sceneRect.left.clamp(0.0, w - 1.0),
      sceneRect.top.clamp(0.0, h - 1.0),
      math.max(4.0, sceneRect.width).clamp(4.0, w),
      math.max(4.0, sceneRect.height).clamp(4.0, h),
    );
    final norm = Rect.fromLTWH(
      (clamped.left / w).clamp(0.0, 1.0),
      (clamped.top / h).clamp(0.0, 1.0),
      (clamped.width / w).clamp(0.0, 1.0),
      (clamped.height / h).clamp(0.0, 1.0),
    );
    widget.onFieldMoved(id, norm);
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.templateSize.width;
    final h = widget.templateSize.height;

    return InteractiveViewer(
      transformationController: _tc, // toScene relies on this [23]
      minScale: 0.25,
      maxScale: 8,
      constrained: false,
      child: Stack(
        clipBehavior: Clip.none, // do not clip field boxes/handles [15][12]
        children: [
          // 1) Template image first (at the bottom) so overlays appear on top [1]
          SizedBox(
            width: w,
            height: h,
            child: Image(
              image: widget.templateImage,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),

          // 2) Field overlays - later children are on top [1]
          for (final f in widget.fields)
            _FieldHandle(
              id: f.id,
              rectScene:
                  Rect.fromLTWH(f.x * w, f.y * h, f.width * w, f.height * h),
              onDragGlobal: (globalStart, globalNow) {
                // Convert both to scene coordinates; compute delta in scene space [22]
                final s = _toScene(globalStart);
                final n = _toScene(globalNow);
                final dx = n.dx - s.dx;
                final dy = n.dy - s.dy;
                final moved = Rect.fromLTWH(
                  f.x * w + dx,
                  f.y * h + dy,
                  f.width * w,
                  f.height * h,
                );
                _saveRect(f.id, moved);
              },
              onResizeGlobal: (globalTopLeft, globalBottomRight) {
                // Convert corners to scene; compute new rect [22]
                final tl = _toScene(globalTopLeft);
                final br = _toScene(globalBottomRight);
                final newRect = Rect.fromPoints(tl, br);
                _saveRect(f.id, newRect);
              },
            ),
        ],
      ),
    );
  }
}

class _FieldHandle extends StatefulWidget {
  final String id;
  final Rect rectScene;
  final void Function(Offset globalStart, Offset globalNow) onDragGlobal;
  final void Function(Offset globalTopLeft, Offset globalBottomRight)
      onResizeGlobal;

  const _FieldHandle({
    super.key,
    required this.id,
    required this.rectScene,
    required this.onDragGlobal,
    required this.onResizeGlobal,
  });

  @override
  State<_FieldHandle> createState() => _FieldHandleState();
}

class _FieldHandleState extends State<_FieldHandle> {
  Offset? _dragGlobalStart;
  Offset? _resizeGlobalStart;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.rectScene.left,
      top: widget.rectScene.top,
      width: widget.rectScene.width,
      height: widget.rectScene.height,
      child: GestureDetector(
        behavior: HitTestBehavior
            .opaque, // ensure drags register over empty parts [24]
        onPanStart: (d) =>
            _dragGlobalStart = d.globalPosition, // use global for toScene [7]
        onPanUpdate: (d) {
          if (_dragGlobalStart != null) {
            widget.onDragGlobal(_dragGlobalStart!, d.globalPosition); // [18]
          }
        },
        onPanEnd: (_) => _dragGlobalStart = null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Visible overlay box
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 2),
                color: Colors.blueAccent.withOpacity(0.10),
              ),
            ),
            // Resize grip at bottom-right corner
            Positioned(
              right: -10,
              bottom: -10,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanStart: (d) => _resizeGlobalStart = d.globalPosition,
                onPanUpdate: (d) {
                  if (_resizeGlobalStart == null) return;
                  // Top-left corner (global) = start of this resize gesture
                  final tlGlobal = _resizeGlobalStart!;
                  final brGlobal = d.globalPosition;
                  widget.onResizeGlobal(tlGlobal, brGlobal);
                },
                onPanEnd: (_) => _resizeGlobalStart = null,
                child: const Icon(Icons.open_in_full,
                    size: 18, color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
