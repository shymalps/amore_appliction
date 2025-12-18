// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileviewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profileviewmodel _$ProfileviewmodelFromJson(Map<String, dynamic> json) =>
    Profileviewmodel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileviewmodelToJson(Profileviewmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
