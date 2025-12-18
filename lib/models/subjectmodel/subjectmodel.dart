import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'subjectmodel.g.dart';

@JsonSerializable()
class Subjectmodel {
  String? status;
  String? message;
  List<Datum>? data;
  int? count;

  Subjectmodel({this.status, this.message, this.data, this.count});

  factory Subjectmodel.fromJson(Map<String, dynamic> json) {
    return _$SubjectmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SubjectmodelToJson(this);
}
