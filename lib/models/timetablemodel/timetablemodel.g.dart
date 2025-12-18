// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetablemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timetablemodel _$TimetablemodelFromJson(Map<String, dynamic> json) =>
    Timetablemodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Timetableitem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimetablemodelToJson(Timetablemodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
