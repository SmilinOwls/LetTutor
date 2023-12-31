import 'package:dio/dio.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/models/tutor/tutor_feedback.dart';
import 'package:lettutor/models/tutor/tutor_info.dart';
import 'package:lettutor/services/dio_service.dart';

class TutorService {
  static Future<void> getListTutorWithPagination({
    required int page,
    required int perPage,
    required Function(int, List<Tutor>, List<Tutor>) onSuccess,
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

      final List<String> tutorIds = [];

      final total = data['tutors']['count'];
      final tutors = data['tutors']['rows'];
      final favoriteTutors = data['favoriteTutor'];

      favoriteTutors.removeWhere((element) => element['secondInfo'] == null);

      final newFavoriteTutors = favoriteTutors.map((favorTutor) {
        tutorIds.add(favorTutor['secondId']);

        final secondInfoTutor = favorTutor['secondInfo'];

        final {"tutorInfo": tutorInfo} = secondInfoTutor;
        secondInfoTutor.removeWhere((key, value) => key == 'tutorInfo');

        secondInfoTutor['isFavorite'] = true;

        return <String, dynamic>{...secondInfoTutor, ...tutorInfo};
      }).toList();

      // remove duplicate tutor
      tutors.removeWhere((element) => tutorIds.contains(element['userId']));

      final tutorList =
          tutors.map<Tutor>((tutor) => Tutor.fromJson(tutor)).toList();
      final favoriteTutorList = newFavoriteTutors
          .map<Tutor>((tutor) => Tutor.fromJson(tutor))
          .toList();
      await onSuccess(total, tutorList, favoriteTutorList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> getTutorInfoById({
    required String userId,
    required Function(TutorInfo) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/tutor/$userId',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final tutorInfo = TutorInfo.fromJson(data);
      await onSuccess(tutorInfo);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    }
  }

  static Future<void> searchTutor({
    required int page,
    required int perPage,
    String search = '',
    Map<String, bool> nationality = const <String, bool>{},
    List<String> specialties = const <String>[],
    required Function(int, List<Tutor>) onSuccess,
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

      final total = data['count'];
      final List<dynamic> tutors = data['rows'];

      final tutorList =
          tutors.map<Tutor>((tutor) => Tutor.fromJson(tutor)).toList();

      await onSuccess(total, tutorList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> reportTutor({
    required String userId,
    required String content,
    required Function() onSuccess,
    required Function(String) onError,
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

      await onSuccess();
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> getTutorFeedback({
    required int page,
    required int perPage,
    required String userId,
    required Function(int,List<TutorFeedback>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/feedback/v2/$userId?perPage=$perPage&page=$page',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final int totalItems = data['data']['count'];
      final List<dynamic> feedbacks = data['data']['rows'];

      final feedbackList = feedbacks
          .map<TutorFeedback>((feedback) => TutorFeedback.fromJson(feedback))
          .toList();

      await onSuccess(totalItems, feedbackList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }
}
