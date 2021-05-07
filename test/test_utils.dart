import 'package:flutter_form_validator/flutter_form_validator_builder.dart';
import 'package:flutter_form_validator/flutter_form_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void checkValidation(
  StringValidationCallback validate, {
  List<String> validValues,
  List<String> invalidValues,
}) {
  if (validValues != null) {
    validValues.forEach((value) {
      expect(validate(value), isNull, reason: '"$value" is valid value');
    });
  }

  if (invalidValues != null) {
    invalidValues.forEach((value) {
      expect(validate(value), isNotNull, reason: '"$value" is invalid value');
    });
  }
}
