import 'package:dio/dio.dart';
import 'package:lettutor/models/misc/learn_topic.dart';
import 'package:lettutor/models/misc/category.dart';
import 'package:lettutor/models/misc/test_preparation.dart';
import 'package:lettutor/services/dio_service.dart';

class MiscService {
  static Future<void> getTestPreparation({
    required Function(List<TestPreparation>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/test-preparation',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final testPreparationList = data
          .map<TestPreparation>(
              (testPreparation) => TestPreparation.fromJson(testPreparation))
          .toList();

      await onSuccess(testPreparationList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> getTopic({
    required Function(List<LearnTopic>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/learn-topic',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final learnTopicList = data
          .map<LearnTopic>((learnTopic) => LearnTopic.fromJson(learnTopic))
          .toList();

      await onSuccess(learnTopicList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> getCategory({
    required Function(List<Category>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/content-category',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final levels = data['rows'];

      final levelList =
          levels.map<Category>((level) => Category.fromJson(level)).toList();

      await onSuccess(levelList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }
}
