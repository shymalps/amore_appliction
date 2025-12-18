// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topicmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topicmodel _$TopicmodelFromJson(Map<String, dynamic> json) => Topicmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => topicitem.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TopicmodelToJson(Topicmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'count': instance.count,
    };
