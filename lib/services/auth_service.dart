import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lettutor/models/user/tokens.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:lettutor/services/dio_service.dart';

class AuthService {
  static User parseUser(String responseBody) =>
      User.fromJson(jsonDecode(responseBody));

  static Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required Function(User, Tokens) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final user = User.fromJson(data['user']);
      final tokens = Tokens.fromJson(data['tokens']);
      await onSuccess(user, tokens);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static loginByGoogle({
    required String accessToken,
    required Function(User, Tokens) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/auth/google',
        data: {
          'access_token': accessToken,
        },
      );
      
      final data = response.data;
      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final user = User.fromJson(data['user']);
      final tokens = Tokens.fromJson(data['tokens']);
      await onSuccess(user, tokens);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static loginByFacebook({
    required String accessToken,
    required Function(User, Tokens) onSuccess,
  }) async {
    final response = await DioService().post(
      '/auth/facebook',
      data: {
        'access_token': accessToken,
      },
    );

    final data = json.decode(response.data);
    if (response.statusCode != 200) {
      throw Exception(data['message']);
    }

    final user = User.fromJson(data['user']);
    final tokens = Tokens.fromJson(data['tokens']);
    await onSuccess(user, tokens);
  }

  static Future<void> continueSession({
    required String refreshToken,
    required Function(User, Tokens) onSuccess,
  }) async {
    final response = await DioService().post(
      '/auth/refresh-token',
      data: {
        'refreshToken': refreshToken,
        'timezone': "7",
      },
    );

    final data = json.decode(response.data);
    if (response.statusCode != 200) {
      throw Exception(data['message']);
    }

    final user = User.fromJson(data['user']);
    final token = Tokens.fromJson(data['tokens']);
    await onSuccess(user, token);
  }

  static Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'source': 'null',
        },
      );

      final data = response.data;

      if (response.statusCode != 201) {
        throw Exception(data['message']);
      }

      await onSuccess();
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> forgotPassword(String email) async {
    final response = await DioService().post(
      '/user/forgotPassword',
      data: {
        'email': email,
      },
    );

    final data = json.decode(response.data);
    if (response.statusCode != 200) {
      throw Exception(data['message']);
    }
  }
}
