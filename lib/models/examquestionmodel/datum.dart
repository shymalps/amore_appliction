import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Questions {
  String? id;
  String? staffid;
  @JsonKey(name: 'class_id')
  String? classId;
  @JsonKey(name: 'subject_id')
  String? subjectId;
  @JsonKey(name: 'topic_id')
  String? topicId;
  String? optiona;
  String? optionb;
  String? optionc;
  String? optiond;
  String? optione;
  String? qns;
  String? ans;
  String? explanation;
  dynamic passagecode;
  String? passageparent;
  dynamic passage;
  String? status;

  Questions({
    this.id,
    this.staffid,
    this.classId,
    this.subjectId,
    this.topicId,
    this.optiona,
    this.optionb,
    this.optionc,
    this.optiond,
    this.optione,
    this.qns,
    this.ans,
    this.explanation,
    this.passagecode,
    this.passageparent,
    this.passage,
    this.status,
  });

  factory Questions.fromJson(Map<String, dynamic> json) =>
      _$QuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsToJson(this);
}
