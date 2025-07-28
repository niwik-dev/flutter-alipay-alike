import 'package:dio/dio.dart';

class HttpUtil {
  static final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  // 通用GET请求
  static Future<T> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        T Function(dynamic)? fromJson,
      }) async {
    return _request<T>(
      path,
      method: 'GET',
      queryParameters: queryParameters,
      fromJson: fromJson,
    );
  }

  // 通用POST请求
  static Future<T> post<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        T Function(dynamic)? fromJson,
      }) async {
    return _request<T>(
      path,
      method: 'POST',
      data: data,
      queryParameters: queryParameters,
      fromJson: fromJson,
    );
  }

  // 核心请求方法
  static Future<T> _request<T>(
      String path, {
        required String method,
        dynamic data,
        Map<String, dynamic>? queryParameters,
        T Function(dynamic)? fromJson,
      }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      // 自动类型转换
      if (fromJson != null) {
        return fromJson(response.data);
      }

      // 默认返回原始数据
      return response.data as T;
    } on DioException catch (e) {
      throw HttpError(
        code: e.response?.statusCode ?? -1,
        message: e.message ?? 'Unknown error',
      );
    }
  }
}

// 自定义HTTP异常
class HttpError implements Exception {
  final int code;
  final String message;

  HttpError({required this.code, required this.message});

  @override
  String toString() => 'HttpError[$code]: $message';
}
