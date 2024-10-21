extension IsNotNull on String? {
  bool get isNotNull {
    if (this != null) {
      return true;
    }
    return false;
  }

  String get notNull {
    if (this != null) {
      return this ?? '';
    }
    return '';
  }
}
