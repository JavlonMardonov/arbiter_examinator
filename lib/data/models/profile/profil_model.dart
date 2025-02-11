import 'package:json_annotation/json_annotation.dart';

part 'profil_model.g.dart';

@JsonSerializable()
class ProfilModel {
  @JsonKey(name: "data")
  final ProfileData? data;

  ProfilModel({
    this.data,
  });

  factory ProfilModel.fromJson(Map<String, dynamic> json) =>
      _$ProfilModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilModelToJson(this);
}

@JsonSerializable()
class ProfileData {
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

  ProfileData({
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

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
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
  @JsonKey(name: "quiz_count_for_candidates")
  final int? quizCountForCandidates;
  @JsonKey(name: "duration")
  final int? duration;
  @JsonKey(name: "pass_quiz_count")
  final int? passQuizCount;

  Exam({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.quizCountForCandidates,
    this.duration,
    this.passQuizCount,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);
}
