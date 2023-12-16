import 'dart:developer';

import '../model/login_model.dart';
import '../model/register_model.dart';
import 'auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/auth_service.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthService _authService;

  AuthRepoImpl({required AuthService authService}) : _authService = authService;
  @override
  Future<Either<Failure, String>> login(LoginModel loginModel) async {
    try {
      return right(await _authService.login(loginModel));
    } catch (e) {
      return left(ServerFailure(
          message: "Login failed, email or password is incorrect"));
    }
  }

  @override
  Future<Either<Failure, String>> register(RegisterModel registerModel) async {
    try {
      return right(await _authService.register(registerModel));
    } on DioException catch (e) {
      log("DioException",
          time: DateTime.now(), name: (e.response?.data ?? {}).toString());
      List errors = e.response?.data["errors"] ?? [];
      late String messages;
      if (errors.isNotEmpty) {
        messages = errors.join("\n");
      } else {
        messages = "Register failed, try again";
      }

      return left(ServerFailure(message: messages));
    } catch (e) {
      return left(ServerFailure(message: "Register failed, try again"));
    }
  }
}
