// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResponse _$QuizResponseFromJson(Map<String, dynamic> json) => QuizResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => QuizData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizResponseToJson(QuizResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

QuizData _$QuizDataFromJson(Map<String, dynamic> json) => QuizData(
      id: json['_id'] as String,
      questions: (json['question'] as List<dynamic>)
          .map((e) => QuestionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      quizType: $enumDecodeNullable(_$QuizTypeEnumMap, json['type'],
              unknownValue: QuizType.unknown) ??
          QuizType.unknown,
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizDataToJson(QuizData instance) => <String, dynamic>{
      '_id': instance.id,
      'question': instance.questions,
      'type': _$QuizTypeEnumMap[instance.quizType]!,
      'options': instance.options,
    };

const _$QuizTypeEnumMap = {
  QuizType.singleSelect: 'single_select',
  QuizType.multiSelect: 'multi_select',
  QuizType.unknown: '',
};
