// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examlistdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Examlistdata _$ExamlistdataFromJson(Map<String, dynamic> json) => Examlistdata(
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => Exam.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ExamlistdataToJson(Examlistdata instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
