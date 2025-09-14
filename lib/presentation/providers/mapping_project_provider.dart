import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/domain/models/mapping_project_model.dart';
import 'package:id_card_generator_app/domain/models/template_field_model.dart';

class MappingProjectNotifier extends Notifier<MappingProject?> {
  @override
  MappingProject? build() => null;

  void setProject(MappingProject project) => state = project;

  void updateField(String id, TemplateField updated) {
    final p = state;
    if (p == null) return;
    state = p.copyWith(
      fields: [
        for (final f in p.fields)
          if (f.id == id) updated else f,
      ],
    );
  }
}

final mappingProjectProvider =
    NotifierProvider<MappingProjectNotifier, MappingProject?>(() {
  return MappingProjectNotifier();
});
