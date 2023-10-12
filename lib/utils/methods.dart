import 'package:intl/intl.dart';

class DateMethods {
  static DateTime? parse(String? date) {
    try {
      return DateTime.parse(date!);
    } catch (e) {
      return null;
    }
  }

  static String? ddMMMyyyy(String date) {
    var parsedDate = parse(date);
    if (parsedDate == null) return "";
    return DateFormat('dd MMM yyyy', 'ID').format(parsedDate);
  }

  static String? ddMMMyy(String date) {
    var parsedDate = parse(date);
    if (parsedDate == null) return "";
    return DateFormat('dd MMM yy', 'ID').format(parsedDate);
  }

  static String? ddMMMMyyyy(String date) {
    var parsedDate = parse(date);
    if (parsedDate == null) return "";
    return DateFormat('dd MMMM yyyy', 'ID').format(parsedDate);
  }

  static String? ddMMMyyyyhhmma(
    dynamic date,
  ) {
    DateTime? parsedDate;
    if (date is DateTime?) {
      parsedDate = date;
    } else if (date is String?) {
      parsedDate = parse(date!);
    }
    parsedDate ??= DateTime.now();
    return DateFormat(
      'dd MMM yyyy hh:mm a',
    ).format(parsedDate);
  }

  static String completeDate(
    dynamic date,
  ) {
    DateTime? parsedDate;
    if (date is DateTime?) {
      parsedDate = date;
    } else if (date is String?) {
      parsedDate = parse(date!);
    }
    parsedDate ??= DateTime.now();
    return DateFormat(
      'EEEE dd MMMM yyyy hh:mm a',
    ).format(parsedDate);
  }

  static String? mMM(String date) {
    var parsedDate = parse(date);
    if (parsedDate == null) return "";
    return DateFormat(
      'MMM',
    ).format(parsedDate);
  }

  static String? mMMyyyy(String date) {
    var parsedDate = parse(date);
    if (parsedDate == null) return "";
    return DateFormat(
      'MMMM yyyy',
    ).format(parsedDate);
  }

  /// Time Converter
  static Duration _getGMTDuration() {
    //get current system local time
    DateTime? currentTime = DateTime?.now();
    //get time diff
    var timezoneOffset = currentTime.timeZoneOffset;
    return Duration(
      hours: timezoneOffset.inHours,
      minutes: timezoneOffset.inMinutes % 60,
    );
  }

  static DateTime? convertToGMT(DateTime? localDate) {
    if (localDate == null) return null;
    final duration = _getGMTDuration();
    return localDate.subtract(duration);
  }

  static DateTime? convertFromGMT(String gmtDate) {
    final oldDate = parse(gmtDate);
    if (oldDate == null) return null;
    final duration = _getGMTDuration();
    return oldDate.add(duration);
  }
}
