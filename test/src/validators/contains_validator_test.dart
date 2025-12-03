import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Contains validator tests', () {
    test(
      'Compare a List of Strings with a String of an email address (invalid)',
      () {
        final control = FormControl<List<String>>.lazy(
          value: ['john@email.com'],
          validators: [
            Validators.contains(['1', '3']),
          ],
        );
        control.updateValueAndValidity(updateParent: false);

        // Expect: control invalid
        expect(control.valid, false);
      },
    );

    test(
      'Compare a List of Strings with a String of all numbers (invalid)',
      () {
        final control = FormControl<List<String>>.lazy(
          value: ['0123456789'],
          validators: [
            Validators.contains(['1', '3']),
          ],
        );
        control.updateValueAndValidity(updateParent: false);

        // Expect: control invalid
        expect(control.valid, false);
      },
    );

    test(
      'Compare a List of Strings with another that contains all of them (valid)',
      () {
        final control = FormControl<List<String>>.lazy(
          value: ['1', '2', '3', '4'],
          validators: [
            Validators.contains(['1', '3']),
          ],
        );

        // Expect: control valid
        expect(control.valid, true);
      },
    );

    test(
      'Compare a list of numbers with another that contains all of them (valid)',
      () {
        final control = FormControl<List<int>>.lazy(
          value: [1, 2, 3, 4],
          validators: [
            Validators.contains([1, 3]),
          ],
        );

        // Expect: control invalid
        expect(control.valid, true);
      },
    );

    test(
      'Compare a list of numbers with another that contains a part of them (invalid)',
      () {
        final control = FormControl<List<int>>.lazy(
          value: [1, 2, 3, 4],
          validators: [
            Validators.contains([1, 3, 5]),
          ],
        );
        control.updateValueAndValidity(updateParent: false);

        // Expect: control invalid
        expect(control.valid, false);
      },
    );

    test(
      'Compare a list of emails with another that contains numbers (invalid)',
      () {
        final control = FormArray<String>.lazy(
          [
            FormControl<String>.lazy(
              value: 'john@email.com',
            ),
            FormControl<String>.lazy(
              value: 'stark@email.com',
            ),
            FormControl<String>.lazy(
              value: 'bob@email.com',
            ),
          ],
          validators: [
            Validators.contains(['doe@email.com']),
          ],
        );
        control.updateValueAndValidity(updateParent: false);

        // Expect: control invalid
        expect(control.valid, false);
      },
    );

    test(
      'Compare a list of numbers with another that contains all of them (valid)',
      () {
        final control = FormArray<int>.lazy(
          [
            FormControl<int>.lazy(
              value: 1,
            ),
            FormControl<int>.lazy(
              value: 2,
            ),
            FormControl<int>.lazy(
              value: 3,
            ),
          ],
          validators: [
            Validators.contains([1, 3]),
          ],
        );

        // Expect: control invalid
        expect(control.valid, true);
      },
    );
  });
}
