// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assignment _$AssignmentFromJson(Map<String, dynamic> json) => Assignment(
  assignmentId: json['assignment_id'] as String?,
  subjectId: json['subject_id'] as String?,
  classId: json['class_id'] as String?,
  topicId: json['topic_id'] as String?,
  teacherId: json['teacher_id'] as String?,
  title: json['title'] as String?,
  qus: json['qus'] as String?,
  mark: json['mark'] as String?,
  fileName: json['file_name'] as String?,
  filesize: json['filesize'] as String?,
  createdAt: json['created_at'] as String?,
  submitMark: json['submit_mark'] as String?,
  submitStatus: json['submit_status'] as String?,
  teacherName: json['teacher_name'] as String?,
);

Map<String, dynamic> _$AssignmentToJson(Assignment instance) =>
    <String, dynamic>{
      'assignment_id': instance.assignmentId,
      'subject_id': instance.subjectId,
      'class_id': instance.classId,
      'topic_id': instance.topicId,
      'teacher_id': instance.teacherId,
      'title': instance.title,
      'qus': instance.qus,
      'mark': instance.mark,
      'file_name': instance.fileName,
      'filesize': instance.filesize,
      'created_at': instance.createdAt,
      'submit_mark': instance.submitMark,
      'submit_status': instance.submitStatus,
      'teacher_name': instance.teacherName,
    };
