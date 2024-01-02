import 'package:intl/intl.dart';
import 'package:lettutor/utils/localization.dart';

class TimeHelper with Localization {
  static String timeAgo(String createdTime) {
    final DateTime dt = DateTime.tryParse(createdTime) ?? DateTime.now();

    Duration diff = DateTime.now().difference(dt);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  static String getRemainingTimer(Duration currentTime) {
    final String days = currentTime.inDays.toString().padLeft(2, '0');
    final String hours =
        currentTime.inHours.remainder(24).toString().padLeft(2, '0');
    final String minutes =
        currentTime.inMinutes.remainder(60).toString().padLeft(2, '0');
    final String seconds =
        currentTime.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$days:$hours:$minutes:$seconds';
  }

  static String convertTimeStampToHour(int timestamp) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final String hour = DateFormat('HH:mm').format(date);
    return hour;
  }

  static String convertTimeStampToDate(int timestamp) {
    final String date = Localization.local?.upcomingDate(DateTime.fromMillisecondsSinceEpoch(timestamp)) ?? '';
    return date;
  }

  static String getMostRecentWeekRangeFromDate(DateTime date) {
    final DateTime monday = date.subtract(Duration(days: date.weekday - 1));
    final DateTime sunday = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    return 'Week: ${DateFormat('dd/MM/yyyy').format(monday)} (Monday)'
        ' - '
        '${DateFormat('dd/MM/yyyy').format(sunday)} (Sunday)';
  }
}
