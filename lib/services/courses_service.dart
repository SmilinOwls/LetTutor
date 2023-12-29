import 'package:dio/dio.dart';
import 'package:lettutor/models/courses/course/course.dart';
import 'package:lettutor/models/courses/ebook/ebook.dart';
import 'package:lettutor/services/dio_service.dart';

class CoursesService {
  static final DioService _dioService = DioService();

  static void getListCourseWithPagination({
    required int page,
    required int size,
    required Function(List<Course>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.get(
        '/course?page=$page&size=$size',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final courses = data['data']['rows'];

      final courseList =
          courses.map<Course>((course) => Course.fromJson(course)).toList();

      await onSuccess(courseList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static void searchCourse({
    required int page,
    required int size,
    String? search,
    List<String>? categoryId,
    List<String>? level,
    String? orderBy,
    required Function(List<Course>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.get(
        '/course',
        params: {
          'page': page,
          'size': size,
          'q': search,
          'categoryId[]': categoryId,
          'level[]': level,
          'order_by[]': orderBy,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final courses = data['data']['rows'];

      final courseList =
          courses.map<Course>((course) => Course.fromJson(course)).toList();

      await onSuccess(courseList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static void getCourseDetailById({
    required String courseId,
    required Function(Course) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.get(
        '/course/$courseId',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final course = data['data'];
      final courseDetail = Course.fromJson(course);

      await onSuccess(courseDetail);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static void getListEbookWithPagination({
    required int page,
    required int size,
    required Function(List<EBook>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.get(
        '/e-book?page=$page&size=$size',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final courses = data['data']['rows'];

      final courseList =
          courses.map<EBook>((course) => EBook.fromJson(course)).toList();

      await onSuccess(courseList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static void searchEbook({
    required int page,
    required int size,
    String? search,
    List<String>? categoryId,
    List<String>? level,
    String? orderBy,
    required Function(List<EBook>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.get(
        '/e-book',
        params: {
          'page': page,
          'size': size,
          'q': search,
          'categoryId[]': categoryId,
          'level[]': level,
          'order_by[]': orderBy,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final courses = data['data']['rows'];

      final courseList =
          courses.map<EBook>((course) => EBook.fromJson(course)).toList();

      await onSuccess(courseList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }
}
