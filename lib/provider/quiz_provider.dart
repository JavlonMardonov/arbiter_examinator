import 'dart:developer';

import 'package:arbiter_examinator/data/repositories/quiz_repo.dart';
import 'package:arbiter_examinator/data/models/quiz/quiz_data.dart';
import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  final QuizRepo quizRepo;

  QuizProvider(this.quizRepo);

  bool isLoading = false;
  String message = '';
  QuizResponse? quiz;

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
}
