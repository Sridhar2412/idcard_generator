import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:id_card_generator_app/domain/models/field_type.dart';

part 'template_field_model.freezed.dart';
part 'template_field_model.g.dart';

@freezed
class TemplateField with _$TemplateField {
  const factory TemplateField({
    required String id,
    required FieldType type,
    required String excelColumn,
    required double x,
    required double y,
    required double width,
    required double height,
    String? fontFamily,
    double? fontSize,
    int? color, // ARGB
    TextAlign? align,
  }) = _TemplateField;

  factory TemplateField.fromJson(Map<String, dynamic> json) =>
      _$TemplateFieldFromJson(json);
}
