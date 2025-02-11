import 'package:arbiter_examinator/common/app/services/injcetion_container.dart';
import 'package:arbiter_examinator/presentation/screens/login_screen.dart';
import 'package:arbiter_examinator/provider/auth_provider.dart';
import 'package:arbiter_examinator/provider/quiz_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initInjection();
  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('uz'),
          Locale('en'),
          Locale("ru"),
          // Locale("cr")
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('uz'),
        startLocale: Locale("en"),
        saveLocale: true,
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<AuthProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<QuizProvider>(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
