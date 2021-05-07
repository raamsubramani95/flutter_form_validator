import 'flutter_form_validator_locale.dart';
import 'all.dart';

typedef StringValidationCallback = String Function(String value);

// C# Action<T>
typedef Action<T> = Function(T builder);

class ValidationBuilder {
  ValidationBuilder({
    String localeName,
    this.optional = false,
    flutter_form_validator_locale locale,
    this.requiredMessage,
  }) : _locale = locale ??
      (localeName == null ? globalLocale : createLocale(localeName)) {
    ArgumentError.checkNotNull(_locale, 'locale');
    if (optional != true) {
      required(requiredMessage);
    }
  }

  static flutter_form_validator_locale globalLocale = createLocale('default');

  static void setLocale(String localeName) {
    globalLocale = createLocale(localeName);
  }

  final bool optional;
  final String requiredMessage;
  final flutter_form_validator_locale _locale;
  final List<StringValidationCallback> validations = [];

  /// Clears validation list and adds required validation if
  /// [optional] is false
  ValidationBuilder reset() {
    validations.clear();
    if (optional != true) {
      required(requiredMessage);
    }
    return this;
  }

  /// Adds new item to [validations] list, returns this instance
  ValidationBuilder add(StringValidationCallback validator) {
    validations.add(validator);
    return this;
  }

  /// Tests [value] against defined [validations]
  String test(String value) {
    for (var validate in validations) {
      // Return null if field is optional and value is null
      if (optional && value == null) {
        return null;
      }

      // Otherwise execute validations
      final result = validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  /// Returns a validator function for FormInput
  StringValidationCallback build() => test;

  /// Throws error only if [left] and [right] validators throw error same time.
  /// If [reverse] is true left builder's error will be displayed otherwise
  /// right builder's error. Because this is default behaviour on most
  /// programming languages.
  ValidationBuilder or(
      Action<ValidationBuilder> left, Action<ValidationBuilder> right,
      {bool reverse = false}) {
    // Create
    final v1 = ValidationBuilder(locale: _locale);
    final v2 = ValidationBuilder(locale: _locale);

    // Configure
    left(v1);
    right(v2);

    // Build
    final v1cb = v1.build();
    final v2cb = v2.build();

    // Test
    return add((value) {
      final leftResult = v1cb(value);
      if (leftResult == null) {
        return null;
      }
      final rightResult = v2cb(value);
      if (rightResult == null) {
        return null;
      }
      return reverse == true ? leftResult : rightResult;
    });
  }

  /// Value must not be null
  ValidationBuilder required([String message]) =>
      add((v) => v == null ? message ?? _locale.required() : null);

  /// Value length must be greater than or equal to [minLength]
  ValidationBuilder minLength(int minLength, [String message]) => add((v) =>
  v.length < minLength ? message ?? _locale.minLength(v, minLength) : null);

  /// Value length must be less than or equal to [maxLength]
  ValidationBuilder maxLength(int maxLength, [String message]) => add((v) =>
  v.length > maxLength ? message ?? _locale.maxLength(v, maxLength) : null);

  /// Value must match [regExp]
  ValidationBuilder regExp(RegExp regExp, String message) =>
      add((v) => regExp.hasMatch(v) ? null : message);

  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  static final RegExp _nonDigitsExp = RegExp(r'[^\d]');
  static final RegExp _anyLetter = RegExp(r'[A-Za-z]');
  static final RegExp _phoneRegExp = RegExp(r'^\d{7,15}$');
  static final RegExp _fname = RegExp(r'[A-Za-z]');
  static final RegExp _lname= RegExp(r'[A-Za-z]');
  static final RegExp _password = RegExp(r'^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');
  static final RegExp _urlRegExp = RegExp(
      r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');

  /// Value must be a well formatted email
  ValidationBuilder email([String message]) =>
      add((v) => _emailRegExp.hasMatch(v) ? null : message ?? _locale.email(v));
  ValidationBuilder password([String message]) =>
      add((v) => _password.hasMatch(v) ? null : message ?? _locale.password(v));
  ValidationBuilder fname([String message]) =>
      add((v) => _fname.hasMatch(v) ? null : message ?? _locale.fname(v));
  ValidationBuilder lname([String message]) =>
      add((v) => _lname.hasMatch(v) ? null : message ?? _locale.lname(v));

  /// Value must be a well formatted phone number
  ValidationBuilder phone([String message]) =>
      add((v) => !_anyLetter.hasMatch(v) &&
          _phoneRegExp.hasMatch(v.replaceAll(_nonDigitsExp, ''))
          ? null
          : message ?? _locale.phoneNumber(v));

  ValidationBuilder url([String message]) =>
      add((v) => _urlRegExp.hasMatch(v) ? null : message ?? _locale.url(v));
}
