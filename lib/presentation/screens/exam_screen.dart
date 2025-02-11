import 'dart:async';

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
  late int exam_duration = widget.profileData.exam!.duration!;
  final List<SubmitQuizData> selectedAnswers = [];
  late Timer _timer;
  late int _remainingTime;

  @override
  void initState() {
    super.initState();
    getIt<QuizProvider>().getQuiz(widget.profileData.exam!.id!);
    _remainingTime = exam_duration;
    _startTimer();
  }

  Future<void> submit() async {
    await getIt<QuizProvider>().submitQuiz(
        examId: widget.profileData.exam!.id!, data: selectedAnswers);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          trueAnswers:
              getIt<QuizProvider>().quizResult?.correctAnswersCount ?? -1,
          allQuestions: getIt<QuizProvider>().quiz!.data.length,
          pass_quiz_count: widget.profileData.exam?.passQuizCount ?? 28,
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secondsLeft = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secondsLeft.toString().padLeft(2, '0')}";
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
          submit();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("exam".tr()),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _formatTime(_remainingTime),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _remainingTime <= exam_duration * 0.1
                      ? Colors.red
                      : Colors.black),
            ),
          ),
          SizedBox(
            width: 90,
          )
        ],
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
