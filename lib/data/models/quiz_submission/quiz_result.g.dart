// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResult _$QuizResultFromJson(Map<String, dynamic> json) => QuizResult(
      correctAnswersCount: (json['total_correct_answer'] as num?)?.toInt(),
      quizPoint: (json['quiz_point'] as num?)?.toInt(),
    );

Map<String, dynamic> _$QuizResultToJson(QuizResult instance) =>
    <String, dynamic>{
      'total_correct_answer': instance.correctAnswersCount,
      'quiz_point': instance.quizPoint,
    };
