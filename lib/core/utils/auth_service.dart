import '../../features/authentication/data/model/login_model.dart';
import '../../features/authentication/data/model/register_model.dart';
import 'package:dio/dio.dart';

import 'api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService({required ApiService apiService}) : _apiService = apiService;

  Future<String> login(LoginModel loginModel) async {
    final response = await _apiService.post(
      body: loginModel.toJson(),
      url: "https://apingweb.com/api/login",
      contentType: Headers.jsonContentType,
    );
    return response.data["token"];
  }

  Future<String> register(RegisterModel registerModel) async {
    final response = await _apiService.post(
      body: registerModel.toJson(),
      url: "https://apingweb.com/api/register",
      contentType: Headers.jsonContentType,
    );
    return response.data["token"];
  }
}
