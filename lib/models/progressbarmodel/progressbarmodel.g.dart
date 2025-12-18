// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progressbarmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Progressbarmodel _$ProgressbarmodelFromJson(Map<String, dynamic> json) =>
    Progressbarmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Baritem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProgressbarmodelToJson(Progressbarmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
