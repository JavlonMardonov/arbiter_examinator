import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'profil_model.g.dart';

@JsonSerializable()
class ProfilModel {
    @JsonKey(name: "data")
    final Data? data;

    ProfilModel({
        this.data,
    });

    factory ProfilModel.fromJson(Map<String, dynamic> json) => _$ProfilModelFromJson(json);

    Map<String, dynamic> toJson() => _$ProfilModelToJson(this);
}

@JsonSerializable()
class Data {
    @JsonKey(name: "_id")
    final String? id;
    @JsonKey(name: "fio")
    final String? fio;
    @JsonKey(name: "candidate_number")
    final String? candidateNumber;
    @JsonKey(name: "role")
    final String? role;
    @JsonKey(name: "is_deleted")
    final bool? isDeleted;
    @JsonKey(name: "is_registered")
    final bool? isRegistered;
    @JsonKey(name: "is_exam_taken")
    final bool? isExamTaken;
    @JsonKey(name: "exam_date")
    final String? examDate;
    @JsonKey(name: "exam")
    final Exam? exam;
    @JsonKey(name: "created_at")
    final String? createdAt;
    @JsonKey(name: "updated_at")
    final String? updatedAt;
    @JsonKey(name: "__v")
    final int? v;
    @JsonKey(name: "last_exam_result")
    final int? lastExamResult;

    Data({
        this.id,
        this.fio,
        this.candidateNumber,
        this.role,
        this.isDeleted,
        this.isRegistered,
        this.isExamTaken,
        this.examDate,
        this.exam,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.lastExamResult,
    });

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Exam {
    @JsonKey(name: "_id")
    final String? id;
    @JsonKey(name: "name")
    final String? name;
    @JsonKey(name: "created_at")
    final String? createdAt;
    @JsonKey(name: "updated_at")
    final String? updatedAt;
    @JsonKey(name: "__v")
    final int? v;

    Exam({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

    Map<String, dynamic> toJson() => _$ExamToJson(this);
}
