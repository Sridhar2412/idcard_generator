import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:id_card_generator_app/domain/models/template_field_model.dart';

class MappedFieldsNotifier extends Notifier<List<TemplateField>> {
  @override
  List<TemplateField> build() => <TemplateField>[];

  void setAll(List<TemplateField> fields) => state = fields;
  void update(String id, TemplateField f) => state = [
        for (final x in state)
          if (x.id == id) f else x
      ];
}

final mappedFieldsProvider =
    NotifierProvider<MappedFieldsNotifier, List<TemplateField>>(
        () => MappedFieldsNotifier());
