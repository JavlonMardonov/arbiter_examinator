import 'dart:developer';
import 'package:arbiter_examinator/data/repositories/auth_repo.dart';
import 'package:arbiter_examinator/data/models/profil_model.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider(this.authRepo);

  bool isLoading = false;
  String message = '';
  ProfilModel? user;

  Future<void> login({
    required String candidate_number,
  }) async {
    isLoading = true;
    notifyListeners();
    log("data in usecase: $candidate_number,");
    final result = await authRepo.login(candidate_number: candidate_number);
    isLoading = false;
    notifyListeners();
    return result.fold(
      (error) => message = error,
      (_) => message = "success",
    );
  }

  Future<void> profile() async {
    isLoading = true;
    notifyListeners();
    log("data in usecase: ");
    final result = await authRepo.getProfile();
    isLoading = false;
    notifyListeners();
    return result?.fold(
      (error) => message = error,
      (_) => user = _,
    );
  }
}
