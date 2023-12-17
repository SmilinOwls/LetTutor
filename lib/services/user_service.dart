import 'package:dio/dio.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:lettutor/services/dio_service.dart';

class UserService {
  static Future<void> getUserInfo({
    required Function(User) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
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
      final response = await DioService().put(
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
}
