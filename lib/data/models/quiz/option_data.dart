import 'package:json_annotation/json_annotation.dart';

part 'option_data.g.dart';

@JsonSerializable()
class OptionData {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'value')
  final List<Map<String, dynamic>> valuesList;
  @JsonKey(name: 'is_correct')
  final bool isCorrect;

  const OptionData({
    required this.id,
    required this.valuesList,
    required this.isCorrect,
  });

  factory OptionData.fromJson(Map<String, dynamic> json) =>
      _$OptionDataFromJson(json);

  Map<String, dynamic> toJson() => _$OptionDataToJson(this);

  String get optionValue {
    return valuesList.isNotEmpty ? valuesList.first['content'] : '';
  }
}
