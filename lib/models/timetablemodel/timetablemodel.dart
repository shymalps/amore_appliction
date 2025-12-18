import 'package:json_annotation/json_annotation.dart';

import 'timetableitem.dart';

part 'timetablemodel.g.dart';

@JsonSerializable()
class Timetablemodel {
  String? status;
  String? message;
  List<Timetableitem>? data;

  Timetablemodel({this.status, this.message, this.data});

  factory Timetablemodel.fromJson(Map<String, dynamic> json) {
    return _$TimetablemodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TimetablemodelToJson(this);
}
