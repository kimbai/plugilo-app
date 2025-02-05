class Validator {
  static const String emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String onlyNumericRegex = '[^0-9]';

  static String cleanPhoneNumber(String numberString) {
    String newNumber = numberString;
    newNumber = newNumber.replaceAll(RegExp(r'[-*#()., ]'), "");
    if (newNumber.startsWith("00")) {
      newNumber = "0${newNumber.substring(2)}";
    }
    if (numberString.startsWith("84")) {
      newNumber = "0${newNumber.substring(2)}";
    }
    const String numBoilerplate = "0123456789";
    String result = "";
    for (int i = 0; i < newNumber.length; i++) {
      if (numBoilerplate.contains(newNumber[i])) {
        result += newNumber[i];
      }
    }
    return result;
  }

  static String cleanPhoneNumberWithInternationalPrefix(String numberString) {
    String newNumber = numberString;
    newNumber = newNumber.replaceAll(RegExp(r'[-+*#()., ]'), "");
    if (newNumber.startsWith("0")) {
      newNumber = newNumber.substring(1);
    }
    const String numBoilerplate = "0123456789";
    String result = "";
    for (int i = 0; i < newNumber.length; i++) {
      if (numBoilerplate.contains(newNumber[i])) {
        result += newNumber[i];
      }
    }
    return "84$result";
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    RegExp regExp = RegExp(r'^(03|05|07|08|09)[0-9]{8}$');
    return regExp.hasMatch(phoneNumber);
  }

  static bool isValidPassword(String password) {
    final RegExp regExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&^#])[A-Za-z\d@$!%*?&^#]{8,}$');
    return regExp.hasMatch(password);
  }

  static bool isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return regex.hasMatch(email);
  }
}
