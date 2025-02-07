// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_quiz_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitQuizData _$SubmitQuizDataFromJson(Map<String, dynamic> json) =>
    SubmitQuizData(
      quizId: json['quiz_id'] as String,
      selectedOptions: (json['selected_options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SubmitQuizDataToJson(SubmitQuizData instance) =>
    <String, dynamic>{
      'quiz_id': instance.quizId,
      'selected_options': instance.selectedOptions,
    };
