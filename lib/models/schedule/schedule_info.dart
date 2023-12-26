import 'package:lettutor/models/tutor/tutor.dart';

class ScheduleInfo {
  String? date;
  String? endTime;
  int? endTimeStamp;
  String? id;
  bool? isDeleted;
  String? startTime;
  int? startTimeStamp;
  String? tutorId;
  Tutor? tutorInfo;

  ScheduleInfo({
    this.date,
    this.endTime,
    this.endTimeStamp,
    this.id,
    this.isDeleted,
    this.startTime,
    this.startTimeStamp,
    this.tutorId,
    this.tutorInfo,
  });

  ScheduleInfo.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    endTime = json['endTime'];
    endTimeStamp = json['endTimestamp'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    startTime = json['startTime'];
    startTimeStamp = json['startTimestamp'];
    tutorId = json['tutorId'];
    tutorInfo = json['tutorInfo'] != null
        ? Tutor.fromJson(json['tutorInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['date'] = date;
    data['endTime'] = endTime;
    data['endTimestamp'] = endTimeStamp;
    data['id'] = id;
    data['isDeleted'] = isDeleted;
    data['startTime'] = startTime;
    data['startTimestamp'] = startTimeStamp;
    data['tutorId'] = tutorId;
    data['tutorInfo'] = tutorInfo?.toJson();

    return data;
  }
}
