import 'package:dio/dio.dart';
import 'package:lettutor/models/schedule/schedule.dart';
import 'package:lettutor/services/dio_service.dart';

class BookingService {
  static final DioService _dioService = DioService();

  static Future<void> getTutorScheduleById({
    required String tutorId,
    required Function(List<Schedule>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/schedule',
        data: {
          'tutorId': tutorId,
        },
      );

      final schedules = response.data['data'];
      final scheduleList = schedules
          .map<Schedule>((schedule) => Schedule.fromJson(schedule))
          .toList();
      await onSuccess(scheduleList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> bookClass({
    required List<String> scheduleDetailIds,
    required String note,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.post(
        '/booking',
        data: {
          'scheduleDetailIds': scheduleDetailIds,
          'note': note,
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

  static Future<void> cancelBookedClass({
    required List<String> scheduleDetailIds,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.delete(
        'booking',
        data: {
          'scheduleDetailIds': scheduleDetailIds,
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
}
