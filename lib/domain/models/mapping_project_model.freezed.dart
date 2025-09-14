// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mapping_project_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MappingProject _$MappingProjectFromJson(Map<String, dynamic> json) {
  return _MappingProject.fromJson(json);
}

/// @nodoc
mixin _$MappingProject {
  String get id => throw _privateConstructorUsedError;
  String get templatePath => throw _privateConstructorUsedError;
  double get templateWidthPx => throw _privateConstructorUsedError;
  double get templateHeightPx => throw _privateConstructorUsedError;
  List<String> get excelColumns => throw _privateConstructorUsedError;
  List<Student> get students => throw _privateConstructorUsedError;
  List<TemplateField> get fields => throw _privateConstructorUsedError;

  /// Serializes this MappingProject to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MappingProject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MappingProjectCopyWith<MappingProject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MappingProjectCopyWith<$Res> {
  factory $MappingProjectCopyWith(
          MappingProject value, $Res Function(MappingProject) then) =
      _$MappingProjectCopyWithImpl<$Res, MappingProject>;
  @useResult
  $Res call(
      {String id,
      String templatePath,
      double templateWidthPx,
      double templateHeightPx,
      List<String> excelColumns,
      List<Student> students,
      List<TemplateField> fields});
}

/// @nodoc
class _$MappingProjectCopyWithImpl<$Res, $Val extends MappingProject>
    implements $MappingProjectCopyWith<$Res> {
  _$MappingProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MappingProject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templatePath = null,
    Object? templateWidthPx = null,
    Object? templateHeightPx = null,
    Object? excelColumns = null,
    Object? students = null,
    Object? fields = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      templatePath: null == templatePath
          ? _value.templatePath
          : templatePath // ignore: cast_nullable_to_non_nullable
              as String,
      templateWidthPx: null == templateWidthPx
          ? _value.templateWidthPx
          : templateWidthPx // ignore: cast_nullable_to_non_nullable
              as double,
      templateHeightPx: null == templateHeightPx
          ? _value.templateHeightPx
          : templateHeightPx // ignore: cast_nullable_to_non_nullable
              as double,
      excelColumns: null == excelColumns
          ? _value.excelColumns
          : excelColumns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      students: null == students
          ? _value.students
          : students // ignore: cast_nullable_to_non_nullable
              as List<Student>,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<TemplateField>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MappingProjectImplCopyWith<$Res>
    implements $MappingProjectCopyWith<$Res> {
  factory _$$MappingProjectImplCopyWith(_$MappingProjectImpl value,
          $Res Function(_$MappingProjectImpl) then) =
      __$$MappingProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String templatePath,
      double templateWidthPx,
      double templateHeightPx,
      List<String> excelColumns,
      List<Student> students,
      List<TemplateField> fields});
}

/// @nodoc
class __$$MappingProjectImplCopyWithImpl<$Res>
    extends _$MappingProjectCopyWithImpl<$Res, _$MappingProjectImpl>
    implements _$$MappingProjectImplCopyWith<$Res> {
  __$$MappingProjectImplCopyWithImpl(
      _$MappingProjectImpl _value, $Res Function(_$MappingProjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of MappingProject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templatePath = null,
    Object? templateWidthPx = null,
    Object? templateHeightPx = null,
    Object? excelColumns = null,
    Object? students = null,
    Object? fields = null,
  }) {
    return _then(_$MappingProjectImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      templatePath: null == templatePath
          ? _value.templatePath
          : templatePath // ignore: cast_nullable_to_non_nullable
              as String,
      templateWidthPx: null == templateWidthPx
          ? _value.templateWidthPx
          : templateWidthPx // ignore: cast_nullable_to_non_nullable
              as double,
      templateHeightPx: null == templateHeightPx
          ? _value.templateHeightPx
          : templateHeightPx // ignore: cast_nullable_to_non_nullable
              as double,
      excelColumns: null == excelColumns
          ? _value._excelColumns
          : excelColumns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      students: null == students
          ? _value._students
          : students // ignore: cast_nullable_to_non_nullable
              as List<Student>,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<TemplateField>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MappingProjectImpl implements _MappingProject {
  const _$MappingProjectImpl(
      {required this.id,
      required this.templatePath,
      required this.templateWidthPx,
      required this.templateHeightPx,
      required final List<String> excelColumns,
      required final List<Student> students,
      required final List<TemplateField> fields})
      : _excelColumns = excelColumns,
        _students = students,
        _fields = fields;

  factory _$MappingProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$MappingProjectImplFromJson(json);

  @override
  final String id;
  @override
  final String templatePath;
  @override
  final double templateWidthPx;
  @override
  final double templateHeightPx;
  final List<String> _excelColumns;
  @override
  List<String> get excelColumns {
    if (_excelColumns is EqualUnmodifiableListView) return _excelColumns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_excelColumns);
  }

  final List<Student> _students;
  @override
  List<Student> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  final List<TemplateField> _fields;
  @override
  List<TemplateField> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  String toString() {
    return 'MappingProject(id: $id, templatePath: $templatePath, templateWidthPx: $templateWidthPx, templateHeightPx: $templateHeightPx, excelColumns: $excelColumns, students: $students, fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MappingProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.templatePath, templatePath) ||
                other.templatePath == templatePath) &&
            (identical(other.templateWidthPx, templateWidthPx) ||
                other.templateWidthPx == templateWidthPx) &&
            (identical(other.templateHeightPx, templateHeightPx) ||
                other.templateHeightPx == templateHeightPx) &&
            const DeepCollectionEquality()
                .equals(other._excelColumns, _excelColumns) &&
            const DeepCollectionEquality().equals(other._students, _students) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      templatePath,
      templateWidthPx,
      templateHeightPx,
      const DeepCollectionEquality().hash(_excelColumns),
      const DeepCollectionEquality().hash(_students),
      const DeepCollectionEquality().hash(_fields));

  /// Create a copy of MappingProject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MappingProjectImplCopyWith<_$MappingProjectImpl> get copyWith =>
      __$$MappingProjectImplCopyWithImpl<_$MappingProjectImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MappingProjectImplToJson(
      this,
    );
  }
}

abstract class _MappingProject implements MappingProject {
  const factory _MappingProject(
      {required final String id,
      required final String templatePath,
      required final double templateWidthPx,
      required final double templateHeightPx,
      required final List<String> excelColumns,
      required final List<Student> students,
      required final List<TemplateField> fields}) = _$MappingProjectImpl;

  factory _MappingProject.fromJson(Map<String, dynamic> json) =
      _$MappingProjectImpl.fromJson;

  @override
  String get id;
  @override
  String get templatePath;
  @override
  double get templateWidthPx;
  @override
  double get templateHeightPx;
  @override
  List<String> get excelColumns;
  @override
  List<Student> get students;
  @override
  List<TemplateField> get fields;

  /// Create a copy of MappingProject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MappingProjectImplCopyWith<_$MappingProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
