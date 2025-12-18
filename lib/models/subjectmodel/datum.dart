import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  @JsonKey(name: 'subject_id')
  String? subjectId;
  String? name;
  @JsonKey(name: 'class_id')
  String? classId;
  @JsonKey(name: 'teacher_id')
  String? teacherId;
  String? year;
  @JsonKey(name: 't_count')
  int? tCount;

  Datum({
    this.subjectId,
    this.name,
    this.classId,
    this.teacherId,
    this.year,
    this.tCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
