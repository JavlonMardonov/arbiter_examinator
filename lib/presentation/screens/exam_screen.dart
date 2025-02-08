import 'dart:developer';

import 'package:arbiter_examinator/common/app/services/injcetion_container.dart';
import 'package:arbiter_examinator/data/models/profile/profil_model.dart';
import 'package:arbiter_examinator/data/models/quiz/option_data.dart';
import 'package:arbiter_examinator/data/models/quiz_submission/submit_quiz_data.dart';
import 'package:arbiter_examinator/presentation/screens/result_screen.dart';
import 'package:arbiter_examinator/presentation/widgets/checkbox_widget.dart';
import 'package:arbiter_examinator/provider/quiz_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamScreen extends StatefulWidget {
  final ProfileData profileData;
  const ExamScreen({super.key, required this.profileData});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int currentIndex = 0;
  final List<SubmitQuizData> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    getIt<QuizProvider>().getQuiz(widget.profileData.exam!.id!);
  }

  Future<void> submit() async {
    await getIt<QuizProvider>().submitQuiz(
        examId: widget.profileData.exam!.id!, data: selectedAnswers);
  }

  Future<void> nextQuestion(
      QuizProvider quizProvider, List<OptionData> selectedOptions) async {
    final quizId = quizProvider.quiz!.data[currentIndex].id;

    final selectedOptionsIdList =
        selectedOptions.map((option) => option.id).toList();

    final currentQuizResult =
        SubmitQuizData(quizId: quizId, selectedOptions: selectedOptionsIdList);

    selectedAnswers.add(currentQuizResult);

    if (currentIndex < quizProvider.quiz!.data.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      await submit();
      print(getIt<QuizProvider>().quizResult);
      print(getIt<QuizProvider>().quizResult?.correctAnswersCount);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            trueAnswers:
                getIt<QuizProvider>().quizResult?.correctAnswersCount ?? -1,
            allQuestions: quizProvider.quiz!.data.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("exam".tr()),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          var quizData = quizProvider.quiz!.data;

          return Column(
            children: [
              Expanded(
                child: CheckboxWidget(
                  quiz: quizData[currentIndex],
                  questionNumber: (currentIndex + 1).toString(),
                  isNextQuizAvailable: currentIndex < quizData.length - 1,
                  onPrimaryButtonTap: (selectedOptions) {
                    nextQuestion(quizProvider, selectedOptions);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
