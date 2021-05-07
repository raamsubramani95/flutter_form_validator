
import 'package:flutter_form_validator/flutter_form_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_utils.dart';

void main() {
  test('validate min length', () {
    final validate = ValidationBuilder().minLength(5).build();

    checkValidation(validate,
        validValues: ['longer', '12345', 'hahagobrr', 'boooooo'],
        invalidValues: ['1234', 'smol', 'haha', 'GO', 'brr']);
  });

  test('validate max length', () {
    final validate = ValidationBuilder().maxLength(5).build();

    checkValidation(validate,
        validValues: ['smol', 'haha', 'boo', '12345', 'beshi'],
        invalidValues: ['something', 'blablah', '123456', 'foooool']);
  });

  test('validate email', () {
    final validate = ValidationBuilder().email().build();

    // What characters are allowed in an email address?
    // ref: https://stackoverflow.com/a/2049510/7616528

    checkValidation(validate, validValues: [
      'user@gmil.com',
      'mani@main.com',
      'email@no-domain',
      'somelonger_email@domain.co.uk',
      'santa.claus@somewhere.us.com',
      'mail?@gmail.com',
      'a@b.c',
    ], invalidValues: [
      'notanemail',
      'email@gmail@mail.com',
      '@g.com',
      'username@',
    ]);
  });

  test('validate phone number', () {
    final validate = ValidationBuilder().phone().build();

    checkValidation(validate, validValues: [
      '+1234567890',
      '+1(234)567-8910',
      '+994555555555',
      '055 555 55 55',
      '050 555 51 22',
    ], invalidValues: [
      '+123 some text 56789',
      '+1234567890123456',
      '+123456',
    ]);
  });

  test('or operator', () {
    final validate = ValidationBuilder()
        .or(
          (builder) => builder.email('wrong email'),
          (builder) => builder.phone('wrong phone'),
          reverse: true,
        )
        .build();

    checkValidation(validate, validValues: [
      '+1234567890',
      '+1(234)567-8910',
      'mail@gmail.com',
      'messenger@messenger.com',
    ], invalidValues: [
      '+123 some text 56789',
      '+1234567890123456',
      'mail@@gmail.com',
    ]);

    expect(validate('nothing'), equals('wrong email'),
        reason: 'reverse is true');
  });

  test('validate url', () {
    final validate = ValidationBuilder().url().build();

    checkValidation(validate, validValues: [
      'https://themisir.com',
      'http://google.com',
      'https://pub.dev/packages/form_validator',
      'https://domain.tld:1234/url/to/page?query=string&another#hash',
      'http://with-symbold.com',
      'https://this.is.sub.domain.tld',
    ], invalidValues: [
      'url-without-protocol.com',
      'htps//invalid.protocol.com',
      'http://invalid-port:PORT/page',
    ]);
  });


  test('validate custom regex', () {
    final validate = ValidationBuilder()
        .regExp(RegExp(r'^([abc]|[^def])+$'), 'wrong')
        .build();

    checkValidation(validate, validValues: [
      'abc',
      'abababab',
      'cbabababc',
    ], invalidValues: [
      'abcd',
      'dddd',
      'def',
      'abaabababababaababfaba',
    ]);
  });
}
