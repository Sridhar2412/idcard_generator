import 'package:freezed_annotation/freezed_annotation.dart';
part 'student_model.freezed.dart';
part 'student_model.g.dart';

@freezed
class Student with _$Student {
  const factory Student({
    required String id,
    required String name,
    String? className,
    String? photoUrl,
    Map<String, String>? extra, // allow arbitrary columns
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
