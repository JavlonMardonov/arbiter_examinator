import 'package:arbiter_examinator/common/app/services/injcetion_container.dart';
import 'package:arbiter_examinator/data/models/profil_model.dart';
import 'package:arbiter_examinator/presentation/screens/result_screen.dart';
import 'package:arbiter_examinator/presentation/widgets/checkbox_widget.dart';
import 'package:arbiter_examinator/provider/quiz_provider.dart';
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
  List<Map<String, dynamic>> selectedAnswers = [];
  int trueAnswers = 0;

  @override
  void initState() {
    super.initState();
    getIt<QuizProvider>().getQuiz(widget.profileData.exam!.id!);
  }

  void nextQuestion(QuizProvider quizProvider, List<String> selectedOptionIds) {
    if (selectedOptionIds.isNotEmpty) {
      for (var optionId in selectedOptionIds) {
        selectedAnswers.add({
          "quizId": quizProvider.quiz!.data[currentIndex].id,
          "optionId": optionId,
        });

        // if (quizProvider.quiz.data(quizProvider.quiz!.data[currentIndex], optionId)) {
        //   trueAnswers++;
        // }
      }
    }

    if (currentIndex < quizProvider.quiz!.data.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            trueAnswers: trueAnswers,
            allQuestions: quizProvider.quiz!.data.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exam")),
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
                    nextQuestion(quizProvider, selectedOptions.map((e) => e.id).toList());
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
