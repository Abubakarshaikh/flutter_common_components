import 'requirement.dart';

abstract final class Validators {
  static bool required(String? value) =>
      value != null && value.trim().isNotEmpty && value != 'null';

  static bool maxLength(String value, int max) => value.length <= max;

  static bool minLength(String value, int min) => value.length >= min;

  static bool email(String value) => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(value);

  /// At least 12 characters with an uppercase, lowercase, digit and special
  /// character.
  static bool strongPassword(String? value) =>
      value != null &&
      Requirement.atLeast12Characters.hasMatch(value) &&
      Requirement.oneDigit.hasMatch(value) &&
      Requirement.oneSpecialCharacter.hasMatch(value) &&
      Requirement.oneLowercaseLetter.hasMatch(value) &&
      Requirement.oneUppercaseLetter.hasMatch(value);
}
