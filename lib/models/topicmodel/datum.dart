import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class topicitem {
  @JsonKey(name: 'topic_id')
  String? topicId;
  @JsonKey(name: 'class_id')
  String? classId;
  @JsonKey(name: 'subject_id')
  String? subjectId;
  @JsonKey(name: 'teacher_id')
  String? teacherId;
  @JsonKey(name: 'topic')
  String? topic;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 't_count')
  int? tCount;

  topicitem({
    this.topicId,
    this.classId,
    this.subjectId,
    this.teacherId,
    this.topic,
    this.createdAt,
    this.tCount,
  });

  factory topicitem.fromJson(Map<String, dynamic> json) =>
      _$topicitemFromJson(json);

  Map<String, dynamic> toJson() => _$topicitemToJson(this);
}
