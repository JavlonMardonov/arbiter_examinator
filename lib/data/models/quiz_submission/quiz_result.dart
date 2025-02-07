import 'package:json_annotation/json_annotation.dart';

part 'quiz_result.g.dart';

@JsonSerializable()
class QuizResult {
  @JsonKey(name: 'total_correct_answer')
  final int? correctAnswersCount;
  @JsonKey(name: 'quiz_point')
  final int? quizPoint;

  const QuizResult({
    this.correctAnswersCount,
    this.quizPoint,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json["data"] ?? json);

  Map<String, dynamic> toJson() => _$QuizResultToJson(this);
}
