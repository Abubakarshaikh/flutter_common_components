import 'dart:ui' show Color;

extension NullableStringX on String? {
  bool get isNotNull => this != null;

  String get orEmpty => this ?? '';
}

extension StringX on String {
  bool get isValidEmail =>
      RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(this);

  bool get isValidName => RegExp(
    r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$",
  ).hasMatch(this);

  bool get isValidPassword => RegExp(r'^.{6,}$').hasMatch(this);

  bool get isValidPhone => RegExp(r'^\+?0[0-9]{10}$').hasMatch(this);

  int tryParseInt() => int.tryParse(this) ?? 0;

  double tryParseDouble() => double.tryParse(this) ?? 0.0;

  String removeAll(Iterable<String> values) => values.fold(
    this,
    (String result, String pattern) => result.replaceAll(pattern, ''),
  );

  /// Parses `#RRGGBB`, `RRGGBB`, `0xAARRGGBB` etc. into a [Color].
  Color toColor() => Color(
    int.parse(removeAll(<String>['0x', '#']).padLeft(8, 'ff'), radix: 16),
  );

  /// Splits the string onto two lines after the 6th character, keeping at
  /// most [maxChars] + 1 characters.
  String wrapAfterSix([int maxChars = 12]) {
    final chars = split('');
    final buffer = StringBuffer();
    final limit = length > maxChars ? maxChars + 1 : length;
    for (var i = 0; i < limit; i++) {
      if (i == 6 && length >= 7) {
        buffer.write('\n');
        if (length > maxChars && chars[i] == ' ') continue;
      }
      buffer.write(chars[i]);
    }
    return buffer.toString();
  }
}
