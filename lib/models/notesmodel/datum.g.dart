// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Noteitem _$NoteitemFromJson(Map<String, dynamic> json) => Noteitem(
  notesId: json['notes_id'] as String?,
  subjectId: json['subject_id'] as String?,
  topicId: json['topic_id'] as String?,
  title: json['title'] as String?,
  descp: json['descp'] as String?,
  fileName: json['file_name'] as String?,
  uploadType: json['upload_type'] as String?,
  createdAt: json['created_at'] as String?,
  dateTime: json['date_time'] as String?,
  fileType: json['file_type'] as String?,
  fileSizeMb: json['file_size_mb'] as String?,
);

Map<String, dynamic> _$NoteitemToJson(Noteitem instance) => <String, dynamic>{
  'notes_id': instance.notesId,
  'subject_id': instance.subjectId,
  'topic_id': instance.topicId,
  'title': instance.title,
  'descp': instance.descp,
  'file_name': instance.fileName,
  'upload_type': instance.uploadType,
  'created_at': instance.createdAt,
  'date_time': instance.dateTime,
  'file_type': instance.fileType,
  'file_size_mb': instance.fileSizeMb,
};
