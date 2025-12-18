import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Audiolist {
  @JsonKey(name: 'audio_id')
  String? audioId;
  @JsonKey(name: 'topic_id')
  String? topicId;
  String? title;
  String? name;
  @JsonKey(name: 'upload_type')
  String? uploadType;
  @JsonKey(name: 'file_size_mb')
  String? fileSizeMb;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'date_time')
  String? dateTime;
  @JsonKey(name: 'file_type')
  String? fileType;

  Audiolist({
    this.audioId,
    this.topicId,
    this.title,
    this.name,
    this.uploadType,
    this.fileSizeMb,
    this.createdAt,
    this.dateTime,
    this.fileType,
  });

  factory Audiolist.fromJson(Map<String, dynamic> json) =>
      _$AudiolistFromJson(json);

  Map<String, dynamic> toJson() => _$AudiolistToJson(this);
}
