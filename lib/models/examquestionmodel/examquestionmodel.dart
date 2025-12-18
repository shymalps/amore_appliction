import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';
import 'exam.dart';

part 'examquestionmodel.g.dart';

@JsonSerializable()
class Examquestionmodel {
  String? status;
  String? message;
  List<Questions>? data;
  @JsonKey(name: 'ques_id')
  List<String>? quesId;
  Exam? exam;

  Examquestionmodel({
    this.status,
    this.message,
    this.data,
    this.quesId,
    this.exam,
  });

  factory Examquestionmodel.fromJson(Map<String, dynamic> json) {
    return _$ExamquestionmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExamquestionmodelToJson(this);
}
