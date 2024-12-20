class XtPackageHelper {
  static String getRemainingTimeText(int hourMinuteTime) {
    final minute = hourMinuteTime.abs() / 60;
    final second = hourMinuteTime.abs() % 60;
    if (hourMinuteTime <= 0) {
      if (minute > 0) {
        return 'Quá hạn: $minute phút';
      } else {
        return 'Quá hạn';
      }
    } else {
      if (minute > 0) {
        return 'Còn $minute phút';
      } else {
        return 'Còn $second giây';
      }
    }
  }
}
