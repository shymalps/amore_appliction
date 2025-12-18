import 'package:json_annotation/json_annotation.dart';

part 'exam.g.dart';

@JsonSerializable()
class Exam {
  String? id;
  String? examdate;
  dynamic instructions;
  @JsonKey(name: 'class_id')
  String? classId;
  @JsonKey(name: 'subject_id')
  String? subjectId;
  @JsonKey(name: 'topic_id')
  String? topicId;
  String? status;
  dynamic academicyear;
  String? markqns;
  String? minusmark;
  String? totaltime;
  dynamic subqns;
  dynamic suborder;
  @JsonKey(name: 'passg_count')
  String? passgCount;
  dynamic staffid;

  Exam({
    this.id,
    this.examdate,
    this.instructions,
    this.classId,
    this.subjectId,
    this.topicId,
    this.status,
    this.academicyear,
    this.markqns,
    this.minusmark,
    this.totaltime,
    this.subqns,
    this.suborder,
    this.passgCount,
    this.staffid,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);
}
