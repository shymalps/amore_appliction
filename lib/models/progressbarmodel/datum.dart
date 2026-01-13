import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Baritem {
  @JsonKey(name: 'class')
  String? datumClass;
  int? no;
  String? name;
  @JsonKey(name: 'seen_notes')
  int? seenNotes;
  int? notes;
  @JsonKey(name: 'seen_video')
  int? seenVideo;
  int? video;
  @JsonKey(name: 'seen_audio')
  int? seenAudio;
  int? audio;
  @JsonKey(name: 'time_takens')
  String? timeTakens;
  @JsonKey(name: 'last_seen')
  String? lastSeen;

  // NEW FIELDS
  String? department;
  String? section;
  @JsonKey(name: 'startdate')
  String? startDate;
  @JsonKey(name: 'enddate')
  String? endDate;

  Baritem({
    this.datumClass,
    this.no,
    this.name,
    this.seenNotes,
    this.notes,
    this.seenVideo,
    this.video,
    this.seenAudio,
    this.audio,
    this.timeTakens,
    this.lastSeen,
    this.department,
    this.section,
    this.startDate,
    this.endDate,
  });

  factory Baritem.fromJson(Map<String, dynamic> json)
      => _$BaritemFromJson(json);

  Map<String, dynamic> toJson() => _$BaritemToJson(this);
}
