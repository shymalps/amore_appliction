// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exam _$ExamFromJson(Map<String, dynamic> json) => Exam(
  id: json['id'] as String?,
  examdate: json['examdate'] as String?,
  instructions: json['instructions'],
  classId: json['class_id'] as String?,
  subjectId: json['subject_id'] as String?,
  topicId: json['topic_id'] as String?,
  status: json['status'] as String?,
  academicyear: json['academicyear'],
  markqns: json['markqns'] as String?,
  minusmark: json['minusmark'] as String?,
  totaltime: json['totaltime'] as String?,
  subqns: json['subqns'],
  suborder: json['suborder'],
  passgCount: json['passg_count'] as String?,
  staffid: json['staffid'],
);

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
  'id': instance.id,
  'examdate': instance.examdate,
  'instructions': instance.instructions,
  'class_id': instance.classId,
  'subject_id': instance.subjectId,
  'topic_id': instance.topicId,
  'status': instance.status,
  'academicyear': instance.academicyear,
  'markqns': instance.markqns,
  'minusmark': instance.minusmark,
  'totaltime': instance.totaltime,
  'subqns': instance.subqns,
  'suborder': instance.suborder,
  'passg_count': instance.passgCount,
  'staffid': instance.staffid,
};
