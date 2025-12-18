// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notesmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notesmodel _$NotesmodelFromJson(Map<String, dynamic> json) => Notesmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Noteitem.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NotesmodelToJson(Notesmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'count': instance.count,
    };
