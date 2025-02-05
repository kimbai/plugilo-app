import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDateString(String? date, {String sourceFormat = 'yyyy-MM-dd HH:mm:ss', String targetFormat = 'dd/MM/yyyy'}) {
    if (date == null || date.isEmpty) {
      return '';
    }
    final format = DateFormat(sourceFormat);
    final dateTime = format.parse(date);
    final newFormat = DateFormat(targetFormat);
    return newFormat.format(dateTime);
  }
}
