extension extString on String {
  bool get isValidEmail {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final RegExp nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final RegExp passwordRegExp = RegExp(
      r'^.{6,}$',
    );
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return isNotEmpty;
  }

  bool get isValidPhone {
    final RegExp phoneRegExp = RegExp(r'^\+?0[0-9]{10}$');
    return phoneRegExp.hasMatch(this);
  }
}
