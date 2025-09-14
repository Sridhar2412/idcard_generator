// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapping_project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MappingProjectImpl _$$MappingProjectImplFromJson(Map<String, dynamic> json) =>
    _$MappingProjectImpl(
      id: json['id'] as String,
      templatePath: json['templatePath'] as String,
      templateWidthPx: (json['templateWidthPx'] as num).toDouble(),
      templateHeightPx: (json['templateHeightPx'] as num).toDouble(),
      excelColumns: (json['excelColumns'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      students: (json['students'] as List<dynamic>)
          .map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
      fields: (json['fields'] as List<dynamic>)
          .map((e) => TemplateField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MappingProjectImplToJson(
        _$MappingProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'templatePath': instance.templatePath,
      'templateWidthPx': instance.templateWidthPx,
      'templateHeightPx': instance.templateHeightPx,
      'excelColumns': instance.excelColumns,
      'students': instance.students,
      'fields': instance.fields,
    };
