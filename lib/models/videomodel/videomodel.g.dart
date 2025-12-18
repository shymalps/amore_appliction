// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videomodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Videomodel _$VideomodelFromJson(Map<String, dynamic> json) => Videomodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Videoitem.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VideomodelToJson(Videomodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'count': instance.count,
    };
