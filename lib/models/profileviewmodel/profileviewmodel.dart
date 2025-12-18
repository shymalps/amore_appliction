import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'profileviewmodel.g.dart';

@JsonSerializable()
class Profileviewmodel {
  String? status;
  String? message;
  Data? data;

  Profileviewmodel({this.status, this.message, this.data});

  factory Profileviewmodel.fromJson(Map<String, dynamic> json) {
    return _$ProfileviewmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileviewmodelToJson(this);
}
