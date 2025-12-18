import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'class_name')
  String? className;
  String? roll;
  String? school;
  String? phone;
  String? email;
  String? name;
  String? birthday;
  @JsonKey(name: 'profile_img')
  String? profileImg;

  Data({
    this.className,
    this.roll,
    this.school,
    this.phone,
    this.email,
    this.name,
    this.birthday,
    this.profileImg,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
