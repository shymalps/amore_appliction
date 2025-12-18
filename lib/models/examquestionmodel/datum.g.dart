// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Questions _$QuestionsFromJson(Map<String, dynamic> json) => Questions(
      id: json['id'] as String?,
      staffid: json['staffid'] as String?,
      classId: json['class_id'] as String?,
      subjectId: json['subject_id'] as String?,
      topicId: json['topic_id'] as String?,
      optiona: json['optiona'] as String?,
      optionb: json['optionb'] as String?,
      optionc: json['optionc'] as String?,
      optiond: json['optiond'] as String?,
      optione: json['optione'] as String?,
      qns: json['qns'] as String?,
      ans: json['ans'] as String?,
      explanation: json['explanation'] as String?,
      passagecode: json['passagecode'],
      passageparent: json['passageparent'] as String?,
      passage: json['passage'],
      status: json['status'] as String?,
    );

Map<String, dynamic> _$QuestionsToJson(Questions instance) => <String, dynamic>{
      'id': instance.id,
      'staffid': instance.staffid,
      'class_id': instance.classId,
      'subject_id': instance.subjectId,
      'topic_id': instance.topicId,
      'optiona': instance.optiona,
      'optionb': instance.optionb,
      'optionc': instance.optionc,
      'optiond': instance.optiond,
      'optione': instance.optione,
      'qns': instance.qns,
      'ans': instance.ans,
      'explanation': instance.explanation,
      'passagecode': instance.passagecode,
      'passageparent': instance.passageparent,
      'passage': instance.passage,
      'status': instance.status,
    };
