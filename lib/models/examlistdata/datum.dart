import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Exam {
  String? name;
  String? topics;
  String? date;
  String? button;
  @JsonKey(name: 'exam_id')
  String? examId;

  Exam({this.name, this.topics, this.date, this.button, this.examId});

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);
}
