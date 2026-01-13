// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
  yourAns: json['your_ans'] as String?,
  explanation: json['explanation'] as String?,
  qns: json['qns'] as String?,
  optionA: json['option_a'] as String?,
  optionB: json['option_b'] as String?,
  optionC: json['option_c'] as String?,
  optionD: json['option_d'] as String?,
  optionE: json['option_e'] as String?,
  currectAnwser: json['currect_anwser'] as String?,
);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
  'your_ans': instance.yourAns,
  'explanation': instance.explanation,
  'qns': instance.qns,
  'option_a': instance.optionA,
  'option_b': instance.optionB,
  'option_c': instance.optionC,
  'option_d': instance.optionD,
  'option_e': instance.optionE,
  'currect_anwser': instance.currectAnwser,
};
