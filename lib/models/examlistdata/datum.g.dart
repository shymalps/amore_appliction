// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exam _$ExamFromJson(Map<String, dynamic> json) => Exam(
      name: json['name'] as String?,
      topics: json['topics'] as String?,
      date: json['date'] as String?,
      button: json['button'] as String?,
      examId: json['exam_id'] as String?,
    );

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
      'name': instance.name,
      'topics': instance.topics,
      'date': instance.date,
      'button': instance.button,
      'exam_id': instance.examId,
    };
