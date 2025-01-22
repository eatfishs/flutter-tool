// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBaseModel<T> _$MyBaseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    MyBaseModel<T>(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$MyBaseModelToJson<T>(
  MyBaseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
