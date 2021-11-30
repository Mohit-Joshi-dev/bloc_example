// Import the test package and Counter class=

import 'package:bloc_example/services/field_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validation', () {
    test('valid email', () {
      //Setup
      final validator = FieldValidation();
      String email = 'mohitjoshi@gmail.com';
      String? value;

      //Act
      value = validator.validateEmail(email);

      //Expect
      expect(value, '');
    });

    test('Invalid email', () {
      //Setup
      final validator = FieldValidation();
      String email = 'mohitjoshigmail.com';
      String? value;

      //Act
      value = validator.validateEmail(email);

      //Expect
      expect(value, 'Please enter a valid email');
    });

    test('Invalid email for empty value', () {
      //Setup
      final validator = FieldValidation();
      String email = '';
      String? value;

      //Act
      value = validator.validateEmail(email);

      //Expect
      expect(value, 'Enter an email');
    });
  });
}
