import 'package:dio/dio.dart';
import 'package:lettutor/config/env.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioService {
  late Dio _dio;
  final IAppEnv _appEnv = appEnv;
  static final DioService _singleton = DioService._internal();

  factory DioService() {
    return _singleton;
  }

  DioService._internal() {
    initializeDio();
  }

  Future<void> initializeDio() async {
    //  const enviroment =
    //       String.fromEnvironment('FLAVOR', defaultValue: 'development');
    //   await dotenv.load(fileName: '.env.$enviroment');

    _dio = Dio(
      BaseOptions(
        baseUrl: _appEnv.baseUrl!,
        connectTimeout: const Duration(seconds: 5000),
        receiveTimeout: const Duration(seconds: 3000),
        contentType: 'application/json',
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Do something before request is sent
          final prefs = await SharedPreferences.getInstance();
          String? accessToken = prefs.getString('access_token');
          if (accessToken != null) {
            options.headers['Authorization'] = "Bearer $accessToken";
          }
          return handler.next(options); // continue
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (error, handler) async {
          // Do something on error
          RequestOptions origin = error.requestOptions;
          final prefs = await SharedPreferences.getInstance();

          if (error.response?.statusCode == 401) {
            try {
              String? refreshToken = prefs.getString('refresh_token');
              Response<dynamic> response = await _dio.post(
                "/auth/refresh-token",
                data: {
                  "refresh_token": refreshToken,
                  "timezone": "7",
                },
              );
              final accessToken = response.data['accessToken'];
              prefs.setString('access_token', accessToken);
              origin.headers['Authorization'] = "Bearer $accessToken";
              return handler.resolve(await _retry(origin));
            } catch (err) {
              await prefs.remove('access_token');
              return handler.reject(error);
            }
          }
          return handler.next(error); // continue
        },
        // ...
      ),
    );
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
  }) async {
    return _dio.get(
      url,
      data: data,
      queryParameters: params,
    );
  }

  Future<Response> post(
    String url, {
    dynamic data,
    String? contentType,
  }) async {
    return _dio.post(
      url,
      data: data,
      options: Options(
        contentType: contentType,
      ),
    );
  }

  Future<Response> put(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return _dio.put(
      url,
      data: data,
    );
  }

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return _dio.delete(
      url,
      data: data,
    );
  }
}
