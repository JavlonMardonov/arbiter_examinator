// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionData _$OptionDataFromJson(Map<String, dynamic> json) => OptionData(
      id: json['_id'] as String,
      valuesList: (json['value'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$OptionDataToJson(OptionData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'value': instance.valuesList,
      'is_correct': instance.isCorrect,
    };
