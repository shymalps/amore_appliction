import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'progressbarmodel.g.dart';

@JsonSerializable()
class Progressbarmodel {
  String? status;
  String? message;
  List<Baritem>? data;

  Progressbarmodel({this.status, this.message, this.data});

  factory Progressbarmodel.fromJson(Map<String, dynamic> json) {
    return _$ProgressbarmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProgressbarmodelToJson(this);
}
