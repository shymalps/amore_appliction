// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Baritem _$BaritemFromJson(Map<String, dynamic> json) => Baritem(
      datumClass: json['class'] as String?,
      no: (json['no'] as num?)?.toInt(),
      name: json['name'] as String?,
      seenNotes: (json['seen_notes'] as num?)?.toInt(),
      notes: (json['notes'] as num?)?.toInt(),
      seenVideo: (json['seen_video'] as num?)?.toInt(),
      video: (json['video'] as num?)?.toInt(),
      seenAudio: (json['seen_audio'] as num?)?.toInt(),
      audio: (json['audio'] as num?)?.toInt(),
      timeTakens: json['time_takens'] as String?,
      lastSeen: json['last_seen'] as String?,
    );

Map<String, dynamic> _$BaritemToJson(Baritem instance) => <String, dynamic>{
      'class': instance.datumClass,
      'no': instance.no,
      'name': instance.name,
      'seen_notes': instance.seenNotes,
      'notes': instance.notes,
      'seen_video': instance.seenVideo,
      'video': instance.video,
      'seen_audio': instance.seenAudio,
      'audio': instance.audio,
      'time_takens': instance.timeTakens,
      'last_seen': instance.lastSeen,
    };
