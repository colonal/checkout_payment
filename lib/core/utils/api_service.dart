import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> post({
    required body,
    required String url,
    String? token,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    final headers0 = {
      "Authorization": 'Bearer $token',
    };
    headers0.addAll(headers ?? {});
    return await _dio.post(
      url,
      data: body,
      options: Options(contentType: contentType, headers: headers0),
    );
  }
}
