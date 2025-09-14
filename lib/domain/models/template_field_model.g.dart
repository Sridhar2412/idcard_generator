// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TemplateFieldImpl _$$TemplateFieldImplFromJson(Map<String, dynamic> json) =>
    _$TemplateFieldImpl(
      id: json['id'] as String,
      type: $enumDecode(_$FieldTypeEnumMap, json['type']),
      excelColumn: json['excelColumn'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      fontFamily: json['fontFamily'] as String?,
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      color: (json['color'] as num?)?.toInt(),
      align: $enumDecodeNullable(_$TextAlignEnumMap, json['align']),
    );

Map<String, dynamic> _$$TemplateFieldImplToJson(_$TemplateFieldImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$FieldTypeEnumMap[instance.type]!,
      'excelColumn': instance.excelColumn,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'fontFamily': instance.fontFamily,
      'fontSize': instance.fontSize,
      'color': instance.color,
      'align': _$TextAlignEnumMap[instance.align],
    };

const _$FieldTypeEnumMap = {
  FieldType.text: 'text',
  FieldType.photo: 'photo',
  FieldType.qr: 'qr',
};

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};
