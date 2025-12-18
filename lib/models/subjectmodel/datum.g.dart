// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      subjectId: json['subject_id'] as String?,
      name: json['name'] as String?,
      classId: json['class_id'] as String?,
      teacherId: json['teacher_id'] as String?,
      year: json['year'] as String?,
      tCount: (json['t_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'subject_id': instance.subjectId,
      'name': instance.name,
      'class_id': instance.classId,
      'teacher_id': instance.teacherId,
      'year': instance.year,
      't_count': instance.tCount,
    };
