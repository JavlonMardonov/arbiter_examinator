import 'dart:developer';
import 'package:arbiter_examinator/common/app/services/injcetion_container.dart';
import 'package:arbiter_examinator/common/exeptions/custom_exception.dart';
import 'package:arbiter_examinator/common/utils/constants/network_constants.dart';
import 'package:arbiter_examinator/common/utils/constants/prefs_keys.dart';
import 'package:arbiter_examinator/data/models/quiz/quiz_data.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizRepo {
  Dio dio = getIt<Dio>();

  QuizRepo();

  Future<Either<dynamic, QuizResponse?>?> getQuiz({
    required String examId,
  }) async {
    log("data in data source: $examId");

    final url = NetworkConstants.quizUrl(examId);
    final String? token =
        getIt<SharedPreferences>().getString(PrefsKeys.tokenKey);

    try {
      final response = await dio.get(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        final payload = response.data;
        return Right(QuizResponse.fromJson(payload));
      }
    } catch (e) {
      Left("Error happened while enter quiz");
      throw ServerException(
        errorMessage: "Error happened while fetching quiz",
        statusCode: 500,
      );
    }
    return null;
  }
}
