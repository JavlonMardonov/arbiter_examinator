class NetworkConstants {
  // base url
  static String baseUrl = "https://api.arbiter-examinator.birnima.uz";

  // auth url
  static String authUrl = "$baseUrl/api/auth/signin";

  // profile url
  static String profleUrl = "$baseUrl/api/profile/me";

  // quiz url

  static String quizUrl(String id) {
    return "$baseUrl/api/exams/$id/quizzes";
  }
}
