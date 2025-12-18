// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignmentmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assignmentmodel _$AssignmentmodelFromJson(Map<String, dynamic> json) =>
    Assignmentmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Assignment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssignmentmodelToJson(Assignmentmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
