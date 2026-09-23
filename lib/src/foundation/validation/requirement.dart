enum Requirement {
  atLeast12Characters(r'^.{12,}$'),
  oneUppercaseLetter('[A-Z]+'),
  oneLowercaseLetter('[a-z]+'),
  oneDigit('[0-9]+'),
  oneSpecialCharacter(r'[!@#$%^&*(),.?":{}|<>]+'),
  emailAddress(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+",
  );

  const Requirement(this.pattern);

  final String pattern;

  bool hasMatch(String value) => RegExp(pattern).hasMatch(value);
}
