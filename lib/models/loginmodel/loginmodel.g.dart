// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loginmodel _$LoginmodelFromJson(Map<String, dynamic> json) => Loginmodel(
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginmodelToJson(Loginmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
