// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Audiolist _$AudiolistFromJson(Map<String, dynamic> json) => Audiolist(
      audioId: json['audio_id'] as String?,
      topicId: json['topic_id'] as String?,
      title: json['title'] as String?,
      name: json['name'] as String?,
      uploadType: json['upload_type'] as String?,
      fileSizeMb: json['file_size_mb'] as String?,
      createdAt: json['created_at'] as String?,
      dateTime: json['date_time'] as String?,
      fileType: json['file_type'] as String?,
    );

Map<String, dynamic> _$AudiolistToJson(Audiolist instance) => <String, dynamic>{
      'audio_id': instance.audioId,
      'topic_id': instance.topicId,
      'title': instance.title,
      'name': instance.name,
      'upload_type': instance.uploadType,
      'file_size_mb': instance.fileSizeMb,
      'created_at': instance.createdAt,
      'date_time': instance.dateTime,
      'file_type': instance.fileType,
    };
