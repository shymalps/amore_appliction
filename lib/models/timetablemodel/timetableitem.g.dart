// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetableitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timetableitem _$TimetableitemFromJson(Map<String, dynamic> json) =>
    Timetableitem(
      classRoutineId: json['class_routine_id'] as String?,
      classId: json['class_id'] as String?,
      sectionId: json['section_id'] as String?,
      subjectId: json['subject_id'] as String?,
      teacherId: json['teacher_id'] as String?,
      timeStart: json['time_start'] as String?,
      timeEnd: json['time_end'] as String?,
      day: json['day'] as String?,
      year: json['year'] as String?,
      subject: json['subject'] as String?,
      teacher: json['teacher'] as String?,
    );

Map<String, dynamic> _$TimetableitemToJson(Timetableitem instance) =>
    <String, dynamic>{
      'class_routine_id': instance.classRoutineId,
      'class_id': instance.classId,
      'section_id': instance.sectionId,
      'subject_id': instance.subjectId,
      'teacher_id': instance.teacherId,
      'time_start': instance.timeStart,
      'time_end': instance.timeEnd,
      'day': instance.day,
      'year': instance.year,
      'subject': instance.subject,
      'teacher': instance.teacher,
    };
