import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:id_card_generator_app/domain/models/student_model.dart';
import 'package:id_card_generator_app/domain/models/template_field_model.dart';

part 'mapping_project_model.freezed.dart';
part 'mapping_project_model.g.dart';

@freezed
class MappingProject with _$MappingProject {
  const factory MappingProject({
    required String id,
    required String templatePath,
    required double templateWidthPx,
    required double templateHeightPx,
    required List<String> excelColumns,
    required List<Student> students,
    required List<TemplateField> fields,
  }) = _MappingProject;

  factory MappingProject.fromJson(Map<String, dynamic> json) =>
      _$MappingProjectFromJson(json);
}
