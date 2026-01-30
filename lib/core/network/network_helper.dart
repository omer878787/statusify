import 'package:dio/dio.dart';

class NetworkHelper {
  static Dio createDio({required String baseUrl, required String openAiKey}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': 'Bearer $openAiKey',
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
