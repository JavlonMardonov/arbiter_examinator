import 'dart:developer';

import 'package:arbiter_examinator/data/models/profile/profil_model.dart';
import 'package:arbiter_examinator/presentation/screens/exam_screen.dart';
import 'package:arbiter_examinator/provider/auth_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();

  final Map<String, String> _flags = {
    "O'zbekcha": "assets/flags/uz.png",
    "Криллча": "assets/flags/uz.png",
    "Русский": "assets/flags/ru.png",
    // "English": "assets/flags/en.png",
  };

  final Map<String, String> _languages = {
    "O'zbekcha": "uz",
    "Криллча": "en",
    "Русский": "ru",
    // "Криллча": "cr",
    // "English": "en",
  };

  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentLocale = context.locale.languageCode;
      _selectedLanguage = _languages.entries
          .firstWhere((entry) => entry.value == currentLocale)
          .key;
      setState(() {});
    });
  }

  void _showDialog(ProfileData data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: data.isExamTaken == true
              ? Icon(Icons.cancel, color: Colors.red, size: 50)
              : Icon(Icons.check_circle, color: Colors.green, size: 50),
          titlePadding: EdgeInsets.all(10),
          content: data.isExamTaken == true
              ? Text("exam_taken".tr())
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("exam".tr()),
                    Text(
                      "${data.exam?.name}",
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
          actions: [
            TextButton(
              onPressed: () {
                if (data.isExamTaken != true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExamScreen(profileData: data)),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
              child:
                  Text(data.isExamTaken != true ? "start".tr() : "cancel".tr()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width =
                constraints.maxWidth > 600 ? 400 : constraints.maxWidth * 0.9;
            return Container(
              width: width,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: "candidate_id".tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedLanguage,
                      decoration: InputDecoration(
                        labelText: "select_lang".tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _flags.keys.map((String language) {
                        return DropdownMenuItem<String>(
                          value: language,
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 20,
                                  child: Image.asset(_flags[language]!)),
                              const SizedBox(width: 8),
                              Text(language),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguage = newValue;
                          Locale newLocale = Locale(_languages[newValue]!);
                          context.setLocale(newLocale);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                      return ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              ElevatedButton(
                                onPressed: _selectedLanguage != null &&
                                        _controller.text.isNotEmpty
                                    ? () async {
                                        await authProvider.login(
                                            candidate_number:
                                                _controller.text.trim());

                                        await authProvider.profile();
                                        log("${authProvider.user?.data?.fio}");
                                        if (authProvider.message
                                            .contains("success")) {
                                          _showDialog(authProvider.user!.data!);
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              authProvider.message.toString() ==
                                                      "success"
                                                  ? "success_auth".tr()
                                                  : "failed_auth".tr(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: authProvider
                                                    .message
                                                    .contains("success")
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        );
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(width, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: authProvider.isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.blueGrey,
                                      )
                                    : Text("login".tr()),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
