class ValidationUtils {
  static bool isEmailValid(String email) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    // Add your password validation logic here
    // For example, check if it's at least 8 characters long
    return password.length >= 8;
  }

  static bool isNameEmpty(String name) {
    return name.trim().isEmpty;
  }

  static bool isLastNameEmpty(String lastName) {
    return lastName.trim().isEmpty;
  }

  static bool isSearchEmpty(String search) {
    return search.trim().isEmpty;
  }
}
