import 'package:easy_localization/easy_localization.dart';
import 'package:plugilo/generated/locale_keys.g.dart';

class StringUtils {
  static final format = NumberFormat.decimalPattern('vi');

  static String numberToCurrency(num amount) {
    return format.format(amount);
  }

  static String currencyStringWithUnit(double? amount, {String? currency = 'đ'}) {
    if (amount == null || amount == 0) return LocaleKeys.free.tr();
    return "${StringUtils.numberToCurrency(amount)}$currency";
  }
}

extension StringUtilities on String {
  String lastChars(int n) => length < n ? this : substring(length - n);
}
