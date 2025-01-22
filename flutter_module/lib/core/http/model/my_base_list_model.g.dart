// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_base_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBaseListModel<T> _$MyBaseListModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    MyBaseListModel<T>(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$MyBaseListModelToJson<T>(
  MyBaseListModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data?.map(toJsonT).toList(),
    };
