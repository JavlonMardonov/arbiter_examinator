import 'package:json_annotation/json_annotation.dart';

part 'submit_quiz_data.g.dart';

@JsonSerializable()
class SubmitQuizData {
  @JsonKey(name: 'quiz_id')
  final String quizId;
  @JsonKey(name: 'selected_options')
  final List<String> selectedOptions;

  const SubmitQuizData({
    required this.quizId,
    required this.selectedOptions,
  });

  factory SubmitQuizData.fromJson(Map<String, dynamic> json) => _$SubmitQuizDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitQuizDataToJson(this);

  @override
  String toString() {
    return 'id: $quizId, selected options ${selectedOptions.toString()}';
  }
}
