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
    return name.isNotEmpty &&
        RegExp(r'^[a-zA-Z\s]+$').hasMatch(name) &&
        name.length >= 2;
  }

  //department
  static bool isValidDepartment(String department) {
    return department.isNotEmpty && department.length >= 2;
  }
}
