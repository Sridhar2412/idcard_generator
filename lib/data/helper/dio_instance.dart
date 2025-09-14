import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioInstanceProvider = StateProvider<DioInstance>((ref) {
  return DioInstance();
});

class DioInstance with DioMixin implements Dio {
  DioInstance({
    this.baseUrl,
  }) {
    final options = BaseOptions(
      baseUrl: baseUrl ?? '',
      contentType: 'application/json',
    );
    this.options = options;
    httpClientAdapter = IOHttpClientAdapter();
  }

  final String? baseUrl;
}
