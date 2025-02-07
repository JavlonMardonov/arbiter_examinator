import 'package:arbiter_examinator/presentation/screens/home_screen.dart';
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
    "English": "🇬🇧",
    "Русский": "🇷🇺",
    "O'zbekcha": "🇺🇿",
  };

  final Map<String, String> _languages = {
    "O'zbekcha": "uz",
    "Русский": "ru",
    "English": "en",
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
                              Text(_flags[language]!),
                              const SizedBox(width: 8),
                              Text(language),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguage = newValue;
                          // log(.toString());
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
                          return ElevatedButton(
                            onPressed: _selectedLanguage != null &&
                                    _controller.text.isNotEmpty
                                ? () async {
                                    await authProvider.login(
                                        candidate_number:
                                            _controller.text.trim());

                                    await authProvider.profile();
                                    log("${authProvider.user?.data?.fio}");
                                    if (authProvider.message
                                        .contains("succesfuly")) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()),
                                      );
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          authProvider.message.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
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
