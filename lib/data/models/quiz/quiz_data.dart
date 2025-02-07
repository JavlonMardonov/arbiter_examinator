import 'option_data.dart';
import 'question_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_data.g.dart';

@JsonSerializable()
class QuizResponse {
  @JsonKey(name: 'data')
  final List<QuizData> data;

  QuizResponse({required this.data});

  factory QuizResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResponseToJson(this);
}

@JsonSerializable()
class QuizData {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'question')
  final List<QuestionData> questions;
  @JsonKey(
    name: 'type',
    unknownEnumValue: QuizType.unknown,
    defaultValue: QuizType.unknown,
  )
  final QuizType quizType;
  @JsonKey(name: 'options')
  final List<OptionData> options;

  QuizData({
    required this.id,
    required this.questions,
    required this.quizType,
    required this.options,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) =>
      _$QuizDataFromJson(json);

  Map<String, dynamic> toJson() => _$QuizDataToJson(this);

  QuestionData get question => questions.first;
}

enum QuizType {
  @JsonValue('single_select')
  singleSelect,
  @JsonValue('multi_select')
  multiSelect,
  @JsonValue('')
  unknown,
}
