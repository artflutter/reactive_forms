import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Required True validator tests', () {
    test('FormControl is invalid if value is false', () {
      // Given: an invalid control
      final control = FormControl<bool>.lazy(
        value: false,
        validators: [Validators.requiredTrue],
      );
      control.updateValueAndValidity(updateParent: false);

      // Expect: control is invalid
      expect(control.valid, false);
      expect(control.errors, {
        ValidationMessage.requiredTrue: {'required': true, 'actual': false},
      });
    });

    test('FormControl is valid if value is true', () {
      // Given: a valid control
      final control = FormControl<bool>.lazy(
        value: true,
        validators: [Validators.requiredTrue],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormControl is invalid if value is null', () {
      // Given: a control with null value
      final control = FormControl<bool>.lazy(
        validators: [Validators.requiredTrue],
      );
      control.updateValueAndValidity(updateParent: false);

      // Expect: control is invalid
      expect(control.valid, false);
      expect(control.errors, {
        ValidationMessage.requiredTrue: {'required': true, 'actual': null},
      });
    });

    test('FormControl is invalid if value change to false', () {
      // Given: a valid control
      final control = FormControl<bool>.lazy(
        value: true,
        validators: [Validators.requiredTrue],
      );

      // When: change the value to false
      control.value = false;

      // Then: control is invalid
      expect(control.valid, false);
      expect(control.errors, {
        ValidationMessage.requiredTrue: {'required': true, 'actual': false},
      });
    });

    test('FormControl is valid if value change to true', () {
      // Given: an invalid control
      final control = FormControl<bool>.lazy(
        value: false,
        validators: [Validators.requiredTrue],
      );

      // When: change the value to true
      control.value = true;

      // Then: control is valid
      expect(control.valid, true);
    });
  });
}
