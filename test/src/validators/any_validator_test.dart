import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Any Validator tests', () {
    test('Control value is null', () {
      final array = FormControl<List<String>>.lazy(
        value: null,
        validators: [
          Validators.any<List<String>?>((value) => value?.isNotEmpty ?? false),
        ],
      );
      array.updateValueAndValidity(updateParent: false);

      expect(array.valid, false);
    });

    test('At least one control in array has no empty value', () {
      // Given: an array of String with one not empty control and a validator
      final array = FormArray<String>.lazy(
        [
          FormControl<String>.lazy(
            value: '',
          ),
          FormControl<String>.lazy(
            value: '',
          ),
          FormControl<String>.lazy(
            value: 'not empty',
          ),
        ],
        validators: [
          Validators.any((String? value) => value?.isNotEmpty ?? false),
        ],
      );

      // Expect: array is valid
      expect(array.valid, true);
    });

    test('All elements in array are empty', () {
      // Given: an array of String with empty controls and a validator
      final array = FormArray<String>.lazy(
        [
          FormControl<String>.lazy(
            value: '',
          ),
          FormControl<String>.lazy(
            value: '',
          ),
          FormControl<String>.lazy(
            value: '',
          ),
        ],
        validators: [
          Validators.any((String? value) => value?.isNotEmpty ?? false),
        ],
      );
      array.updateValueAndValidity(updateParent: false);

      // Expect: array is invalid and has
      expect(array.invalid, true);
      expect(array.hasError(ValidationMessage.any), true);
    });

    test('At least one control in array is not null or empty', () {
      final array = FormArray<String>.lazy(
        [
          // Given: an array of String with one not empty control and a validator
          FormControl<String>.lazy(
            value: null,
          ),
          FormControl<String>.lazy(
            value: '',
          ),
          FormControl<String>.lazy(
            value: 'not empty',
          ),
        ],
        validators: [
          Validators.any((String? value) => value?.isNotEmpty ?? false),
        ],
      );

      // Expect: array is valid
      expect(array.valid, true);
    });

    test(
      'At least one control in array has not empty value and controls with null values (invalid)',
      () {
        final array = FormArray<String>.lazy(
          [
            // Given: an array with empty and null values and the validator
            FormControl<String>.lazy(
              value: null,
            ),
            FormControl<String>.lazy(
              value: '',
            ),
            FormControl<String>.lazy(
              value: null,
            ),
          ],
          validators: [
            Validators.any((String? value) => value?.isNotEmpty ?? false),
          ],
        );
        array.updateValueAndValidity(updateParent: false);

        // Expect: array is invalid and has
        expect(array.invalid, true);
        expect(array.hasError(ValidationMessage.any), true);
      },
    );

    test('At least one element in control\'s value is not empty (invalid)', () {
      final control = FormControl<List<String?>>.lazy(
        value: [null, null, ''],
        validators: [
          Validators.any((String? value) => value?.isNotEmpty ?? false),
        ],
      );
      control.updateValueAndValidity(updateParent: false);

      // Expect: array is invalid and has
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.any), true);
    });

    test('At least one element in control\'s value is not empty (valid)', () {
      // Given: a control that is a list of String
      final control = FormControl<List<String?>>.lazy(
        value: [null, null, 'not empty'],
        validators: [
          Validators.any((String? value) => value?.isNotEmpty ?? false),
        ],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });
  });
}
