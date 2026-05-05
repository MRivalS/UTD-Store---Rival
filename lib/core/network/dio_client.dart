import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true, 
        ),
      );
  }

  Dio get instance => _dio;
}
