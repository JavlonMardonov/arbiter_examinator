import 'package:json_annotation/json_annotation.dart';

part 'question_data.g.dart';

@JsonSerializable()
class QuestionData {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'is_complete')
  final bool isComplete;

  const QuestionData({
    required this.id,
    required this.type,
    required this.content,
    required this.isComplete,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) =>
      _$QuestionDataFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDataToJson(this);
}
