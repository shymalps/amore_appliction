import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'videomodel.g.dart';

@JsonSerializable()
class Videomodel {
  String? status;
  String? message;
  List<Videoitem>? data;
  int? count;

  Videomodel({this.status, this.message, this.data, this.count});

  factory Videomodel.fromJson(Map<String, dynamic> json) {
    return _$VideomodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VideomodelToJson(this);
}
