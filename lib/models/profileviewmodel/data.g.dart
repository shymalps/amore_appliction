// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  className: json['class_name'] as String?,
  roll: json['roll'] as String?,
  school: json['school'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  name: json['name'] as String?,
  birthday: json['birthday'] as String?,
  profileImg: json['profile_img'] as String?,
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'class_name': instance.className,
  'roll': instance.roll,
  'school': instance.school,
  'phone': instance.phone,
  'email': instance.email,
  'name': instance.name,
  'birthday': instance.birthday,
  'profile_img': instance.profileImg,
};
