import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/models/schedule/schedule_info.dart';

class ScheduleDetail {
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  String? createdAt;
  String? updatedAt;
  List<BookingInfo>? bookingInfo;
  bool? isBooked;
  ScheduleInfo? scheduleInfo;

  ScheduleDetail({
    this.startPeriodTimestamp,
    this.endPeriodTimestamp,
    this.id,
    this.scheduleId,
    this.startPeriod,
    this.endPeriod,
    this.createdAt,
    this.updatedAt,
    this.bookingInfo,
    this.isBooked,
    this.scheduleInfo,
  });

  ScheduleDetail.fromJson(Map<String, dynamic> json) {
    startPeriodTimestamp = json['startPeriodTimestamp'];
    endPeriodTimestamp = json['endPeriodTimestamp'];
    id = json['id'];
    scheduleId = json['scheduleId'];
    startPeriod = json['startPeriod'];
    endPeriod = json['endPeriod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isBooked = json['isBooked'];
    bookingInfo = json['bookingInfo']?.map<BookingInfo>((info) {
      return BookingInfo.fromJson(info);
    }).toList();
    scheduleInfo = json['scheduleInfo'] != null
        ? ScheduleInfo.fromJson(json['scheduleInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['startPeriodTimestamp'] = startPeriodTimestamp;
    data['endPeriodTimestamp'] = endPeriodTimestamp;
    data['id'] = id;
    data['scheduleId'] = scheduleId;
    data['startPeriod'] = startPeriod;
    data['endPeriod'] = endPeriod;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isBooked'] = isBooked;
    data['bookingInfo'] = bookingInfo?.map((info) {
      return info.toJson();
    }).toList();
    data['scheduleInfo'] = scheduleInfo?.toJson();
    
    return data;
  }
}

