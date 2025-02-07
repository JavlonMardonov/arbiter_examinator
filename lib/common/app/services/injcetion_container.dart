import 'package:arbiter_examinator/data/repositories/quiz_repo.dart';
import 'package:arbiter_examinator/data/repositories/auth_repo.dart';
import 'package:arbiter_examinator/provider/auth_provider.dart';
import 'package:arbiter_examinator/provider/quiz_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initInjection() async {
  getIt.registerLazySingleton(
    () => Dio(),
  );
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  await authInit();
  // await homeInit();
}

Future<void> authInit() async {
  getIt
    ..registerLazySingleton<AuthProvider>(
      () => AuthProvider(getIt()),
    )
    ..registerLazySingleton<QuizProvider>(
      () => QuizProvider(getIt()),
    )
    ..registerLazySingleton<QuizRepo>(
      () => QuizRepo(),
    )
    ..registerLazySingleton<AuthRepo>(
      () => AuthRepo(),
    );
}

// // home
// Future<void> homeInit() async {
//   getIt
//     ..registerLazySingleton(() => GetBannersUsecase(homeRepo: getIt()))
//     ..registerLazySingleton<HomeRepo>(
//         () => HomeRepoImpl(homeRemoteDataSource: getIt()))
//     ..registerLazySingleton<HomeRemoteDataSource>(
//         () => HomeRemoteDataSourceImpl())
//     ..registerLazySingleton<HomeProvider>(() => HomeProvider())
//     ..registerLazySingleton(
//       () => GetCardsUsecases(homeRepo: getIt()),
//     );
// }
