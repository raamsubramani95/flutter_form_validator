import 'flutter_form_validator_locale.dart';
import 'en.dart';

const supportedLocales = <String>{
  'en',
};

const localeMap = <String, flutter_form_validator_locale>{
  'en': LocaleEn(),
};

flutter_form_validator_locale createLocale(String locale) {
  if (locale == 'default') locale = 'en';

  final result = localeMap[locale];
  if (result != null) return result;

  throw ArgumentError.value(
    locale,
    'locale',
    'Form validation locale is not yet supported.',
  );
}
