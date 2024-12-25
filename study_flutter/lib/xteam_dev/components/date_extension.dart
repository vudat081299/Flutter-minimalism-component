import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Returns a new DateTime object representing the start of the day
  /// (00:00:00.000) for this DateTime instance.
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  String text(String format) {
    return DateFormat(format).format(this);
  }
}
