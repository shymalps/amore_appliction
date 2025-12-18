import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'assignmentmodel.g.dart';

@JsonSerializable()
class Assignmentmodel {
  String? status;
  String? message;
  List<Assignment>? data;

  Assignmentmodel({this.status, this.message, this.data});

  factory Assignmentmodel.fromJson(Map<String, dynamic> json) {
    return _$AssignmentmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AssignmentmodelToJson(this);
}
