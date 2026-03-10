import 'package:intl/intl.dart';

class DateFormatter {

  static DateTime parse(String date) {
    return DateTime.parse(date).toLocal();
  }

  static String date(String date) {
    final parsed = parse(date);
    return DateFormat('dd MMM yyyy', 'id_ID').format(parsed);
  }

  static String time(String date) {
    final parsed = parse(date);
    return DateFormat('HH:mm', 'id_ID').format(parsed);
  }

  static String timeFull(String date) {
    final parsed = parse(date);
    return DateFormat('HH:mm:ss', 'id_ID').format(parsed);
  }

  static String dateTimeFull(String date) {
    final parsed = parse(date);
    return DateFormat('dd MMM yyyy • HH:mm:ss', 'id_ID').format(parsed);
  }

  static String timeAgo(String date) {
    final parsed = parse(date);
    final now = DateTime.now();

    final diff = now.difference(parsed);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds} detik lalu';
    }

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} menit lalu';
    }

    if (diff.inHours < 24) {
      return '${diff.inHours} jam lalu';
    }

    if (diff.inDays < 7) {
      return '${diff.inDays} hari lalu';
    }

    return dateTimeFull(date);
  }
}