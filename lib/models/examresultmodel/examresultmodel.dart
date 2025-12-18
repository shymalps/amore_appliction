import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';
import 'f_result.dart';

part 'examresultmodel.g.dart';

@JsonSerializable()
class Examresultmodel {
	String? status;
	String? message;
	List<Datum>? data;
	@JsonKey(name: 'f_result') 
	FResult? fResult;

	Examresultmodel({this.status, this.message, this.data, this.fResult});

	factory Examresultmodel.fromJson(Map<String, dynamic> json) {
		return _$ExamresultmodelFromJson(json);
	}

	Map<String, dynamic> toJson() => _$ExamresultmodelToJson(this);
}
