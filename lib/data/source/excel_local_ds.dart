import 'dart:typed_data';

import 'package:id_card_generator_app/core/utils/app_utlis.dart';

class ExcelLocalDataSource {
  Future<(List<String> columns, List<Map<String, String>> rows)> parse(
      Uint8List bytes) async {
    final decoded = AppUtlis.decode(bytes);
    final columns = decoded.columns;
    final maps = decoded.rows.map((r) {
      final map = <String, String>{};
      for (var i = 0; i < columns.length; i++) {
        map[columns[i]] = (i < r.length ? (r[i]?.toString() ?? '') : '');
      }
      return map;
    }).toList();
    return (columns, maps);
  }
}
