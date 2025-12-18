import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'audiomodel.g.dart';

@JsonSerializable()
class Audiomodel {
  String? status;
  String? message;
  List<Audiolist>? data;
  int? count;

  Audiomodel({this.status, this.message, this.data, this.count});

  factory Audiomodel.fromJson(Map<String, dynamic> json) {
    return _$AudiomodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AudiomodelToJson(this);
}
