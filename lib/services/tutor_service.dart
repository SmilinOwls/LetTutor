import 'package:dio/dio.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/services/dio_service.dart';

class TutorService {
  static Future<void> getListTutorWithPagination({
    required int page,
    required int perPage,
    required Function(List<Tutor>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/tutor/more?perPage=$perPage&page=$page',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final List<dynamic> tutors = data['tutors']['rows'];

      await onSuccess(
          tutors.map<Tutor>((tutor) => Tutor.fromJson(tutor)).toList());
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  // static Future<TutorInfo> getTutorInfoById({
  //   required String token,
  //   required String userId,
  // }) async {
  //   final response = await get(
  //     Uri.parse('$baseUrl/tutor/$userId'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   final jsonDecode = json.decode(response.body);

  //   if (response.statusCode != 200) {
  //     throw Exception(jsonDecode['message']);
  //   }

  //   return TutorInfo.fromJson(jsonDecode);
  // }

  static Future<void> searchTutor({
    required int page,
    required int perPage,
    String search = '',
    Map<String, bool> nationality = const <String, bool>{},
    List<String> specialties = const <String>[],
    required Function(List<Tutor>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/tutor/search',
        data: {
          'page': page,
          'perPage': perPage,
          'search': search,
          'filters': {
            'specialties': specialties,
            'nationality': nationality,
          },
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final List<dynamic> tutors = data['rows'];

      onSuccess(
        tutors.map((tutor) => Tutor.fromJson(tutor)).toList(),
      );
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> addTutorToFavorite({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await DioService().post(
        '/user/manageFavoriteTutor',
        data: {
          'tutorId': userId,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    }
  }

  static Future<void> reportTutor({
    required String userId,
    required String content,
  }) async {
    try {
      final response = await DioService().post(
        '/report',
        data: {
          'tutorId': userId,
          'content': content,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    }
  }
}
