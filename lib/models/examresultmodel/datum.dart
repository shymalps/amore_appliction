import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
	@JsonKey(name: 'your_ans') 
	String? yourAns;
	String? explanation;
	String? qns;
	@JsonKey(name: 'option_a') 
	String? optionA;
	@JsonKey(name: 'option_b') 
	String? optionB;
	@JsonKey(name: 'option_c') 
	String? optionC;
	@JsonKey(name: 'option_d') 
	String? optionD;
	@JsonKey(name: 'option_e') 
	String? optionE;
	@JsonKey(name: 'currect_anwser') 
	String? currectAnwser;

	Datum({
		this.yourAns, 
		this.explanation, 
		this.qns, 
		this.optionA, 
		this.optionB, 
		this.optionC, 
		this.optionD, 
		this.optionE, 
		this.currectAnwser, 
	});

	factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

	Map<String, dynamic> toJson() => _$DatumToJson(this);
}
