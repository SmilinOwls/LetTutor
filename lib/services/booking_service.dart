import 'package:dio/dio.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
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
      final response = await _dioService.post(
        '/schedule',
        data: {
          'tutorId': tutorId,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final schedules = data['data'];

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

  static Future<void> getBookingListByStudent({
    required int page,
    required int perPage,
    int inFuture = 1,
    String orderBy = 'meeting',
    String sortBy = 'asc',
    required Function(List<BookingInfo>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.get(
        '/booking/list/student?page=$page&perPage=$perPage&inFuture=$inFuture&orderBy=$orderBy&sortBy=$sortBy',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final bookingInfo = data['data']['rows'];

      final bookingList = bookingInfo
          .map<BookingInfo>((booking) => BookingInfo.fromJson(booking))
          .toList();
      await onSuccess(bookingList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> hanldeBookingStudentRequest({
    required String bookingId,
    required String studentRequest,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.post(
        '/booking/student-request/$bookingId',
        data: {
          'studentRequest': studentRequest,
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
        '/booking',
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
