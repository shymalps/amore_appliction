import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'examlistdata.g.dart';

@JsonSerializable()
class Examlistdata {
  String? status;
  String? message;
  List<Exam>? data;

  Examlistdata({this.status, this.message, this.data});

  factory Examlistdata.fromJson(Map<String, dynamic> json) {
    return _$ExamlistdataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExamlistdataToJson(this);
}
