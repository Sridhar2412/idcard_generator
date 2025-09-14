import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:id_card_generator_app/core/utils/app_utlis.dart';

class PhotoSource {
  PhotoSource(this._dio);
  final Dio _dio;

  Future<List<int>> photoDownloadBytes(String url) async {
    final res = await _dio.get<List<int>>(url,
        options: Options(responseType: ResponseType.bytes));
    return res.data ?? <int>[];
  }

  Future<(Uint8List bytes, double width, double height)> templateFromPath(
      String path) async {
    final bytes = await File(path).readAsBytes();
    final (w, h) = await AppUtlis.decodeImageSize(bytes);
    return (bytes, w, h);
  }

  Future<(Uint8List bytes, double width, double height)> templateFromBytes(
      Uint8List bytes) async {
    final (w, h) = await AppUtlis.decodeImageSize(bytes);
    return (bytes, w, h);
  }

  Future<(List<String> columns, List<Map<String, String>> rows)> excelParse(
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
