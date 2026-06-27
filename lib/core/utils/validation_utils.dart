class ValidationUtils {
  //email
  static bool isValidEmail(String email) {
    return RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    ).hasMatch(email);
  }

  //phone
  static bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.length == 10 &&
        RegExp(r'^[0-9]+$').hasMatch(phoneNumber);
  }

  //password
  static bool isValidPassword(String password1, String password2) {
    return password1.length >= 6 && password1 == password2;
  }

  //name
  static bool isValidName(String name) {
    final trimmedName = name.trim();

    return trimmedName.isNotEmpty &&
        RegExp(
          '^[a-zA-Z'
          '\u00C0\u00C1\u00C2\u00C3\u00C8\u00C9\u00CA\u00CC\u00CD'
          '\u00D2\u00D3\u00D4\u00D5\u00D9\u00DA\u0102\u0110\u0128'
          '\u0168\u01A0\u01AF\u00E0\u00E1\u00E2\u00E3\u00E8\u00E9'
          '\u00EA\u00EC\u00ED\u00F2\u00F3\u00F4\u00F5\u00F9\u00FA'
          '\u0103\u0111\u0129\u0169\u01A1\u01B0\u1EA0-\u1EF9\\s]+\$',
        ).hasMatch(trimmedName) &&
        trimmedName.length >= 2;
  }

  //department
  static bool isValidDepartment(String department) {
    return department.isNotEmpty && department.length >= 2;
  }
}
