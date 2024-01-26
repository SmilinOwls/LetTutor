import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:lettutor/services/dio_service.dart';

class UserService {
  static final DioService _dioService = DioService();

  static Future<void> getUserInfo({
    required Function(User) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.get(
        '/user/info',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final user = User.fromJson(data['user']);
      await onSuccess(user);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> updateInfo({
    User? updateUser,
    required Function(User?) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.put(
        '/user/info',
        data: {
          'name': updateUser?.name,
          'country': updateUser?.country,
          'birthday': updateUser?.birthday,
          'level': updateUser?.level,
          'learnTopics': updateUser?.learnTopics?.map((e) => e.id).toList(),
          'testPreparations':
              updateUser?.testPreparations?.map((e) => e.id).toList(),
          'studySchedule': updateUser?.studySchedule,
        },
      );

      final data = response.data;
      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final user = User.fromJson(data['user']);
      await onSuccess(user);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
    
  }

  static Future<void> handleFavorite({
    required String userId,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.post(
        '/user/manageFavoriteTutor',
        data: {
          'tutorId': userId,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      await onSuccess();
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<String?> feedbackTutor({
    required String bookingId,
    required String content,
    required int rating,
    required String userId,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.post(
        '/user/feedbackTutor',
        data: {
          'bookingId': bookingId,
          'content': content,
          'rating': rating,
          'userId': userId,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      return await onSuccess();
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
    
    return null;
  }

  static Future<void> uploadImage({
    required File image,
    required Function(User) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.post(
        '/user/uploadAvatar',
        data: FormData.fromMap({
          'avatar': await MultipartFile.fromFile(image.path),
        }),
        
        contentType: 'multipart/form-data',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final user = User.fromJson(data['user']);

      await onSuccess(user);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }
}
