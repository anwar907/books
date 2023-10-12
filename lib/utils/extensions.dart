import 'package:intl/intl.dart';

extension DateTimeParese on String {
  String parseDate(DateTime? date) {
    return DateFormat('dd MMM yyyy').format(date ?? DateTime.now());
  }
}

extension FirestCharacter on String {
  String firstValue() {
    return split('').firstWhere((element) => element.contains(element),
        orElse: () => 'Loading..');
  }
}
