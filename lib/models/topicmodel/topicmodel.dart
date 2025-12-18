import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'topicmodel.g.dart';

@JsonSerializable()
class Topicmodel {
  String? status;
  String? message;
  List<topicitem>? data;
  int? count;

  Topicmodel({this.status, this.message, this.data, this.count});

  factory Topicmodel.fromJson(Map<String, dynamic> json) {
    return _$TopicmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopicmodelToJson(this);
}
