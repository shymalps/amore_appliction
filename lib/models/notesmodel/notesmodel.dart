import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'notesmodel.g.dart';

@JsonSerializable()
class Notesmodel {
  String? status;
  String? message;
  List<Noteitem>? data;
  int? count;

  Notesmodel({this.status, this.message, this.data, this.count});

  factory Notesmodel.fromJson(Map<String, dynamic> json) {
    return _$NotesmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotesmodelToJson(this);
}
