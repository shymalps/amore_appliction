// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Videoitem _$VideoitemFromJson(Map<String, dynamic> json) => Videoitem(
  videoId: json['video_id'] as String?,
  topicId: json['topic_id'] as String?,
  name: json['name'] as String?,
  createdAt: json['created_at'] as String?,
  dateTime: json['date_time'] as String?,
  uploadType: json['upload_type'] as String?,
  fileSizeMb: json['file_size_mb'],
  fileType: json['file_type'] as String?,
  videoname: json['videoname'] as String?,
  pMode: json['p_mode'] as String?,
  yLink: json['y_link'] as String?,
  description: json['description'],
);

Map<String, dynamic> _$VideoitemToJson(Videoitem instance) => <String, dynamic>{
  'video_id': instance.videoId,
  'topic_id': instance.topicId,
  'name': instance.name,
  'created_at': instance.createdAt,
  'date_time': instance.dateTime,
  'upload_type': instance.uploadType,
  'file_size_mb': instance.fileSizeMb,
  'file_type': instance.fileType,
  'videoname': instance.videoname,
  'p_mode': instance.pMode,
  'y_link': instance.yLink,
  'description': instance.description,
};
