// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiomodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Audiomodel _$AudiomodelFromJson(Map<String, dynamic> json) => Audiomodel(
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => Audiolist.fromJson(e as Map<String, dynamic>))
      .toList(),
  count: (json['count'] as num?)?.toInt(),
);

Map<String, dynamic> _$AudiomodelToJson(Audiomodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'count': instance.count,
    };
