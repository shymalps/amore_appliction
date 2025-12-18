import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Videoitem {
  @JsonKey(name: 'video_id')
  String? videoId;
  @JsonKey(name: 'topic_id')
  String? topicId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'date_time')
  String? dateTime;
  @JsonKey(name: 'upload_type')
  String? uploadType;
  @JsonKey(name: 'file_size_mb')
  dynamic fileSizeMb;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'videoname')
  String? videoname;
  @JsonKey(name: 'p_mode')
  String? pMode;
  @JsonKey(name: 'y_link')
  String? yLink;
  dynamic description;

  Videoitem({
    this.videoId,
    this.topicId,
    this.name,
    this.createdAt,
    this.dateTime,
    this.uploadType,
    this.fileSizeMb,
    this.fileType,
    this.videoname,
    this.pMode,
    this.yLink,
    this.description,
  });

  factory Videoitem.fromJson(Map<String, dynamic> json) =>
      _$VideoitemFromJson(json);

  Map<String, dynamic> toJson() => _$VideoitemToJson(this);
}
