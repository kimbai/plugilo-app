import 'package:plugilo/core/utils/validator.dart';

extension ValidationExtension on String? {
  bool _hasMatch(String pattern) => RegExp(pattern).hasMatch(pattern);

  //VALIDATION
  bool get isEmail => _hasMatch(Validator.emailRegex);
}
