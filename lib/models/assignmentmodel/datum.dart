import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Assignment {
  @JsonKey(name: 'assignment_id')
  String? assignmentId;
  @JsonKey(name: 'subject_id')
  String? subjectId;
  @JsonKey(name: 'class_id')
  String? classId;
  @JsonKey(name: 'topic_id')
  String? topicId;
  @JsonKey(name: 'teacher_id')
  String? teacherId;
  String? title;
  String? qus;
  String? mark;
  @JsonKey(name: 'file_name')
  String? fileName;
  String? filesize;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'submit_mark')
  String? submitMark;
  @JsonKey(name: 'submit_status')
  String? submitStatus;
  @JsonKey(name: 'teacher_name')
  String? teacherName;

  Assignment({
    this.assignmentId,
    this.subjectId,
    this.classId,
    this.topicId,
    this.teacherId,
    this.title,
    this.qus,
    this.mark,
    this.fileName,
    this.filesize,
    this.createdAt,
    this.submitMark,
    this.submitStatus,
    this.teacherName,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentToJson(this);
}
