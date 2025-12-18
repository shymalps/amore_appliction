import 'package:json_annotation/json_annotation.dart';

part 'f_result.g.dart';

@JsonSerializable()
class FResult {
	@JsonKey(name: 'total_ans') 
	dynamic? totalAns;
	@JsonKey(name: 'total_worng') 
	dynamic? totalWorng;
	@JsonKey(name: 'total_mark') 
	dynamic? totalMark;

	FResult({this.totalAns, this.totalWorng, this.totalMark});

	factory FResult.fromJson(Map<String, dynamic> json) {
		return _$FResultFromJson(json);
	}

	Map<String, dynamic> toJson() => _$FResultToJson(this);
}
