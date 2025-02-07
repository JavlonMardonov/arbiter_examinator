import 'dart:convert';
import 'dart:developer';

import 'package:arbiter_examinator/common/app/services/injcetion_container.dart';
import 'package:arbiter_examinator/common/exeptions/custom_exception.dart';
import 'package:arbiter_examinator/common/utils/constants/network_constants.dart';
import 'package:arbiter_examinator/common/utils/constants/prefs_keys.dart';
import 'package:arbiter_examinator/data/models/profil_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  Dio dio = getIt<Dio>();

  AuthRepo();

  Future<Either<dynamic, String>> login({
    required String candidate_number,
  }) async {
    log("data in data source: $candidate_number");

    final url = NetworkConstants.authUrl;
    final data = {
      "candidate_number": candidate_number,
    };

    try {
      final response = await dio.post(url, data: jsonEncode(data));
      log("Response $response");
      if (response.statusCode == 201) {
        log(response.statusCode.toString());
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            PrefsKeys.tokenKey, response.data["data"]["access_token"]);
        log(response.data["data"]["access_token"]);
      }
      return Right("Login SUccesfully" ?? "Error");
    } on DioException catch (e) {
      // if (e.response?.statusCode == 404) {
      //   throw ServerException(errorMessage: "Not Found", statusCode: 404);
      // }
      log("Error happened: while logging in: $e");
      return Left("Not found");
    } catch (e) {
      throw ServerException(
          errorMessage: "Please try again later.", statusCode: 500);
    }
  }

  Future<Either<dynamic, ProfilModel?>?> getProfile() async {
    final String? token =
        getIt<SharedPreferences>().getString(PrefsKeys.tokenKey);

    try {
      final response = await dio.get(NetworkConstants.profleUrl,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        final payload = response.data;
        return Right(ProfilModel.fromJson(payload));
      }
    } catch (e) {
      Left("Error happened while enter profile");
      throw ServerException(
        errorMessage: "Error happened while fetching banners",
        statusCode: 500,
      );
    }
    return null;
  }
}
