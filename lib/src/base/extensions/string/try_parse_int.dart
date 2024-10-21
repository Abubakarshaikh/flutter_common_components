extension StringExtensions on String {
  int tryParseInt() {
    return int.tryParse(this) ?? 0;
  }
}
