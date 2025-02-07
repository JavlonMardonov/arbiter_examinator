// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionData _$QuestionDataFromJson(Map<String, dynamic> json) => QuestionData(
      id: json['_id'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      isComplete: json['is_complete'] as bool,
    );

Map<String, dynamic> _$QuestionDataToJson(QuestionData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'content': instance.content,
      'is_complete': instance.isComplete,
    };
