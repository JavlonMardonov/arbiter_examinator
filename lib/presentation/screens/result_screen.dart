import 'package:arbiter_examinator/common/utils/constants/prefs_keys.dart';
import 'package:arbiter_examinator/presentation/screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget {
  final int trueAnswers;
  final int allQuestions;
  final int pass_quiz_count;

  const ResultScreen(
      {super.key,
      required this.trueAnswers,
      required this.allQuestions,
      required this.pass_quiz_count});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late bool isSuccess;

  @override
  void initState() {
    super.initState();
    clearToken();
    isSuccess = widget.trueAnswers >= widget.pass_quiz_count;

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrefsKeys.tokenKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("result".tr()),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   "all_questions".tr(args: [widget.allQuestions.toString()]),
                //   style: TextStyle(fontSize: 22),
                // ),
                // SizedBox(height: 10),
                Text(
                  "correct_answers".tr(
                      args: ["${widget.allQuestions}/${widget.trueAnswers}"]),
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 20),
                isSuccess
                    ? Icon(Icons.check_circle, color: Colors.green, size: 50)
                    : Icon(Icons.cancel, color: Colors.red, size: 50),
                SizedBox(height: 20),
                Text(
                  isSuccess ? "exam_success".tr() : "exam_fail".tr(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isSuccess ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text("to_home".tr()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
