// this is a helper class to manage form validation, but I plan to remove it in place of the FormBuilder package
class AuthHelper {
  static final upperCasePattern = RegExp('((.*[A-Z]){2})');
  static final lowerCasePattern = RegExp('((.*[a-z]){3})');
  static final specialCharsPattern = RegExp('((.*[!@#\$&*]){1})');
  static final digitsPattern = RegExp('((.*[0-9]){2})');
  static final lengthPattern = RegExp('.{8}');
  static final emailPattern = RegExp(
      '(?:[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

  static isEmail(String email) {
    return match(email, emailPattern);
  }

  static isPassword(String password) {
    final List<bool> cases = [
      match(password, digitsPattern),
      match(password, upperCasePattern),
      match(password, lengthPattern),
      match(password, specialCharsPattern),
    ];

    return cases.every((_case) => _case);
  }

  static bool match(String matcher, RegExp pattern) {
    return pattern.allMatches(matcher).isNotEmpty;
  }
}
