// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examquestionmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Examquestionmodel _$ExamquestionmodelFromJson(Map<String, dynamic> json) =>
    Examquestionmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Questions.fromJson(e as Map<String, dynamic>))
          .toList(),
      quesId:
          (json['ques_id'] as List<dynamic>?)?.map((e) => e as String).toList(),
      exam: json['exam'] == null
          ? null
          : Exam.fromJson(json['exam'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExamquestionmodelToJson(Examquestionmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'ques_id': instance.quesId,
      'exam': instance.exam,
    };
