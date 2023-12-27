class TimeHelper {
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
}
