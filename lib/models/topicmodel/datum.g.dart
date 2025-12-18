// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

topicitem _$topicitemFromJson(Map<String, dynamic> json) => topicitem(
      topicId: json['topic_id'] as String?,
      classId: json['class_id'] as String?,
      subjectId: json['subject_id'] as String?,
      teacherId: json['teacher_id'] as String?,
      topic: json['topic'] as String?,
      createdAt: json['created_at'] as String?,
      tCount: (json['t_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$topicitemToJson(topicitem instance) => <String, dynamic>{
      'topic_id': instance.topicId,
      'class_id': instance.classId,
      'subject_id': instance.subjectId,
      'teacher_id': instance.teacherId,
      'topic': instance.topic,
      'created_at': instance.createdAt,
      't_count': instance.tCount,
    };
