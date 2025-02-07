// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profil_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilModel _$ProfilModelFromJson(Map<String, dynamic> json) => ProfilModel(
      data: json['data'] == null
          ? null
          : ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfilModelToJson(ProfilModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ProfileData _$DataFromJson(Map<String, dynamic> json) => ProfileData(
      id: json['_id'] as String?,
      fio: json['fio'] as String?,
      candidateNumber: json['candidate_number'] as String?,
      role: json['role'] as String?,
      isDeleted: json['is_deleted'] as bool?,
      isRegistered: json['is_registered'] as bool?,
      isExamTaken: json['is_exam_taken'] as bool?,
      examDate: json['exam_date'] as String?,
      exam: json['exam'] == null
          ? null
          : Exam.fromJson(json['exam'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      lastExamResult: (json['last_exam_result'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(ProfileData instance) => <String, dynamic>{
      '_id': instance.id,
      'fio': instance.fio,
      'candidate_number': instance.candidateNumber,
      'role': instance.role,
      'is_deleted': instance.isDeleted,
      'is_registered': instance.isRegistered,
      'is_exam_taken': instance.isExamTaken,
      'exam_date': instance.examDate,
      'exam': instance.exam,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      '__v': instance.v,
      'last_exam_result': instance.lastExamResult,
    };

Exam _$ExamFromJson(Map<String, dynamic> json) => Exam(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      '__v': instance.v,
    };
