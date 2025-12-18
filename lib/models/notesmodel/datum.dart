import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Noteitem {
  @JsonKey(name: 'notes_id')
  String? notesId;
  @JsonKey(name: 'subject_id')
  String? subjectId;
  @JsonKey(name: 'topic_id')
  String? topicId;
  @JsonKey(name: 'title')
  String? title;
  String? descp;
  @JsonKey(name: 'file_name')
  String? fileName;
  @JsonKey(name: 'upload_type')
  String? uploadType;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'date_time')
  String? dateTime;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'file_size_mb')
  String? fileSizeMb;

  Noteitem({
    this.notesId,
    this.subjectId,
    this.topicId,
    this.title,
    this.descp,
    this.fileName,
    this.uploadType,
    this.createdAt,
    this.dateTime,
    this.fileType,
    this.fileSizeMb,
  });

  factory Noteitem.fromJson(Map<String, dynamic> json) =>
      _$NoteitemFromJson(json);

  Map<String, dynamic> toJson() => _$NoteitemToJson(this);
}
