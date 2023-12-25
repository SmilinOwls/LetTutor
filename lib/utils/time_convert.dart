import 'package:intl/intl.dart';

String convertTimeStampToHour(int timestamp) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final String hour = DateFormat('HH:mm').format(date);
  return hour;
}
