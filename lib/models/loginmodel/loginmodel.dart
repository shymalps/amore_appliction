import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'loginmodel.g.dart';

@JsonSerializable()
class Loginmodel {
  String? status;
  String? message;
  Data? data;

  Loginmodel({this.status, this.message, this.data});

  factory Loginmodel.fromJson(Map<String, dynamic> json) {
    return _$LoginmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginmodelToJson(this);
}
