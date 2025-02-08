import 'dart:developer';

import 'package:arbiter_examinator/data/models/quiz_submission/quiz_result.dart';
import 'package:arbiter_examinator/data/models/quiz_submission/submit_quiz_data.dart';
import 'package:arbiter_examinator/data/repositories/quiz_repo.dart';
import 'package:arbiter_examinator/data/models/quiz/quiz_data.dart';
import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  final QuizRepo quizRepo;

  QuizProvider(this.quizRepo);

  bool isLoading = false;
  String message = '';
  QuizResponse? quiz;
  QuizResult? quizResult;

  Future<void> getQuiz(String examId) async {
    isLoading = true;
    notifyListeners();
    log("data in usecase: ");
    final result = await quizRepo.getQuiz(examId: examId);
    isLoading = false;
    notifyListeners();
    return result?.fold(
      (error) => message = error,
      (_) => quiz = _,
    );
  }

  Future<void> submitQuiz({
    required String examId,
    required List<SubmitQuizData> data,
  }) async {
    isLoading = true;
    notifyListeners();
    // log("data in usecase: ${data} $examId");
    log(data.toString());
    final result = await quizRepo.submitQiuz(examId: examId, data: data);
    log(result.toString());
    isLoading = false;
    notifyListeners();
    return result?.fold(
      (error) => message = error,
      (_) => quizResult = _,
    );
  }
}
