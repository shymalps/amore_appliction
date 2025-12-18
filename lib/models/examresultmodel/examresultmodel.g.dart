// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examresultmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Examresultmodel _$ExamresultmodelFromJson(Map<String, dynamic> json) =>
    Examresultmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      fResult: json['f_result'] == null
          ? null
          : FResult.fromJson(json['f_result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExamresultmodelToJson(Examresultmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'f_result': instance.fResult,
    };
