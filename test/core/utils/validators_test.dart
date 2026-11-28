import 'package:flutter_test/flutter_test.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/utils/validators.dart';

void main() {
  group('AppValidators - Full Name', () {
    test('Empty or null returns enterFullName error', () {
      expect(AppValidators.validateFullName(null), AppStrings.enterFullName);
      expect(AppValidators.validateFullName(''), AppStrings.enterFullName);
      expect(AppValidators.validateFullName('   '), AppStrings.enterFullName);
    });

    test('Single word or short names return invalidFullName error', () {
      expect(AppValidators.validateFullName('Noah'), AppStrings.invalidFullName);
      expect(AppValidators.validateFullName('N H'), AppStrings.invalidFullName);
    });

    test('Valid full name returns null', () {
      expect(AppValidators.validateFullName('Noah Hassan'), isNull);
      expect(AppValidators.validateFullName('Mohamed Twakl Ahmed'), isNull);
    });
  });

  group('AppValidators - National ID', () {
    test('Empty or null returns enterNationalId error', () {
      expect(AppValidators.validateNationalId(null), AppStrings.enterNationalId);
      expect(AppValidators.validateNationalId(''), AppStrings.enterNationalId);
      expect(AppValidators.validateNationalId('   '), AppStrings.enterNationalId);
    });

    test('Non-14-digit strings return invalidNationalId error', () {
      expect(AppValidators.validateNationalId('1234567890123'), AppStrings.invalidNationalId); // 13 digits
      expect(AppValidators.validateNationalId('123456789012345'), AppStrings.invalidNationalId); // 15 digits
      expect(AppValidators.validateNationalId('2990101123456a'), AppStrings.invalidNationalId); // contains letter
      expect(AppValidators.validateNationalId('2990101123456!'), AppStrings.invalidNationalId); // contains symbol
    });

    test('Valid 14-digit National ID returns null', () {
      expect(AppValidators.validateNationalId('29901011234567'), isNull);
      expect(AppValidators.validateNationalId('30101011234567'), isNull);
    });
  });

  group('AppValidators - Email or Phone Number', () {
    test('Empty or null returns enterEmailOrPhone error', () {
      expect(AppValidators.validateEmailOrPhone(null), AppStrings.enterEmailOrPhone);
      expect(AppValidators.validateEmailOrPhone(''), AppStrings.enterEmailOrPhone);
      expect(AppValidators.validateEmailOrPhone('   '), AppStrings.enterEmailOrPhone);
    });

    test('Phone numbers: length must be 11 digits', () {
      expect(AppValidators.validateEmailOrPhone('0101234567'), AppStrings.invalidPhoneLength); // 10 digits
      expect(AppValidators.validateEmailOrPhone('010123456789'), AppStrings.invalidPhoneLength); // 12 digits
    });

    test('Phone numbers: must begin with 01 followed by {0, 1, 2, 5}', () {
      expect(AppValidators.validateEmailOrPhone('01012345678'), isNull); // 010
      expect(AppValidators.validateEmailOrPhone('01112345678'), isNull); // 011
      expect(AppValidators.validateEmailOrPhone('01212345678'), isNull); // 012
      expect(AppValidators.validateEmailOrPhone('01512345678'), isNull); // 015

      // Invalid prefixes
      expect(AppValidators.validateEmailOrPhone('01312345678'), AppStrings.invalidPhonePrefix);
      expect(AppValidators.validateEmailOrPhone('01412345678'), AppStrings.invalidPhonePrefix);
      expect(AppValidators.validateEmailOrPhone('01612345678'), AppStrings.invalidPhonePrefix);
      expect(AppValidators.validateEmailOrPhone('02123456789'), AppStrings.invalidPhonePrefix);
    });

    test('Email addresses: must end with @gmail.com', () {
      expect(AppValidators.validateEmailOrPhone('user@gmail.com'), isNull);
      expect(AppValidators.validateEmailOrPhone('user.name+tag@gmail.com'), isNull);
      expect(AppValidators.validateEmailOrPhone('USER@GMAIL.COM'), isNull);

      // Non-gmail domains
      expect(AppValidators.validateEmailOrPhone('user@yahoo.com'), AppStrings.invalidGmailDomain);
      expect(AppValidators.validateEmailOrPhone('user@outlook.com'), AppStrings.invalidGmailDomain);
      expect(AppValidators.validateEmailOrPhone('user@gmail.com.eg'), AppStrings.invalidGmailDomain);
    });

    test('Email addresses: invalid structure with @gmail.com', () {
      expect(AppValidators.validateEmailOrPhone('@gmail.com'), AppStrings.invalidGmail);
    });

    test('Arbitrary non-digit and non-email string returns invalidEmailOrPhone error', () {
      expect(AppValidators.validateEmailOrPhone('notanemailorphone'), AppStrings.invalidEmailOrPhone);
    });
  });

  group('AppValidators - Password', () {
    test('Empty or null returns enterPassword error', () {
      expect(AppValidators.validatePassword(null), AppStrings.enterPassword);
      expect(AppValidators.validatePassword(''), AppStrings.enterPassword);
    });

    test('Length must be between 6 and 10 characters', () {
      expect(AppValidators.validatePassword('P@s1'), AppStrings.passwordLength); // 4 chars
      expect(AppValidators.validatePassword('P@ss1'), AppStrings.passwordLength); // 5 chars
      expect(AppValidators.validatePassword('Password123!'), AppStrings.passwordLength); // 12 chars
      expect(AppValidators.validatePassword('Passw0rd!!X'), AppStrings.passwordLength); // 11 chars
    });

    test('Must include at least one uppercase letter', () {
      expect(AppValidators.validatePassword('p@ss12'), AppStrings.passwordUppercase);
    });

    test('Must include at least one lowercase letter', () {
      expect(AppValidators.validatePassword('P@SS12'), AppStrings.passwordLowercase);
    });

    test('Must include at least one number', () {
      expect(AppValidators.validatePassword('P@ssword'), AppStrings.passwordNumber);
    });

    test('Must include at least one special character', () {
      expect(AppValidators.validatePassword('Pass1234'), AppStrings.passwordSpecialChar);
    });

    test('Valid passwords between 6 and 10 characters with all requirements return null', () {
      expect(AppValidators.validatePassword('P@ss12'), isNull); // 6 chars
      expect(AppValidators.validatePassword('Secret123!'), isNull); // 10 chars
      expect(AppValidators.validatePassword('Mem0ra#'), isNull); // 7 chars
      expect(AppValidators.validatePassword('A1b2c3d\$'), isNull); // 8 chars
    });
  });

  group('AppValidators - New Password & Confirm Password (Figma Frame 1:1157)', () {
    test('validateNewPassword under 6 chars returns dynamic notice', () {
      expect(AppValidators.validateNewPassword('Pass'), 'Use at least 6 characters. You’ve entered 4.');
      expect(AppValidators.validateNewPassword('P@s12'), 'Use at least 6 characters. You’ve entered 5.');
    });

    test('validateNewPassword valid password returns null', () {
      expect(AppValidators.validateNewPassword('P@ss12'), isNull);
    });

    test('validateConfirmPassword empty returns enterConfirmPassword error', () {
      expect(AppValidators.validateConfirmPassword(null, 'P@ss12'), AppStrings.enterConfirmPassword);
      expect(AppValidators.validateConfirmPassword('', 'P@ss12'), AppStrings.enterConfirmPassword);
    });

    test('validateConfirmPassword mismatch returns passwordsDoNotMatch error', () {
      expect(AppValidators.validateConfirmPassword('Different1!', 'P@ss12'), AppStrings.passwordsDoNotMatch);
    });

    test('validateConfirmPassword matching returns null', () {
      expect(AppValidators.validateConfirmPassword('P@ss12', 'P@ss12'), isNull);
    });
  });
}
