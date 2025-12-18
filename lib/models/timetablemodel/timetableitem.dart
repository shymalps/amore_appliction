import 'package:json_annotation/json_annotation.dart';

part 'timetableitem.g.dart';

@JsonSerializable()
class Timetableitem {
  @JsonKey(name: 'class_routine_id')
  String? classRoutineId;
  @JsonKey(name: 'class_id')
  String? classId;
  @JsonKey(name: 'section_id')
  String? sectionId;
  @JsonKey(name: 'subject_id')
  String? subjectId;
  @JsonKey(name: 'teacher_id')
  String? teacherId;
  @JsonKey(name: 'time_start')
  String? timeStart;
  @JsonKey(name: 'time_end')
  String? timeEnd;
  String? day;
  String? year;
  String? subject;
  String? teacher;

  Timetableitem({
    this.classRoutineId,
    this.classId,
    this.sectionId,
    this.subjectId,
    this.teacherId,
    this.timeStart,
    this.timeEnd,
    this.day,
    this.year,
    this.subject,
    this.teacher,
  });

  factory Timetableitem.fromJson(Map<String, dynamic> json) =>
      _$TimetableitemFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableitemToJson(this);
}
