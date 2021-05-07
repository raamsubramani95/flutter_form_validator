import 'flutter_form_validator_locale.dart';

class LocaleEn implements flutter_form_validator_locale {
  const LocaleEn();

  @override
  String name() => 'en';

  @override
  String minLength(String v, int n) {
    if (v.length == 0) {
      return "Required";
    } else
      return "'The field must be at least $n characters long';";
  }

  @override
  String maxLength(String v, int n) =>
      'The field must be at most $n characters long';

  @override
  String email(String v) {
    if (v.length == 0) {
      return "Email is Required";
    } else
      return "Invalid Email";

   return 'The field is not a valid email address';
  }

  @override
  String phoneNumber(String v) {
    if (v.length == 0) {
      return "Mobile Number is Required";
    } else if(v.length != 10){
      return "Mobile  Number must 10 digits";
    }else
      return "Mobile  Number must be digits";
  }
  @override
  String password(String v) {
    if (v.length == 0) {
      return "Password is Required";
    } else
      return "UpperCase,LowerCase,NumberorSpecialCharacters";
  }
  @override
  String fname(String v) {
    if (v.length == 0) {
      return "First Name  is Required";
    } else
      return "First Name must be a-z and A-Z";
  }
  @override
  String lname(String v) {
    if (v.length == 0) {
      return "Last Name  is Required";
    }else
      return "Last Name must be a-z and A-Z";
  }

  @override
  String required() => 'Required';

  @override
  String url(String v) => 'The field is not a valid URL address';
}
