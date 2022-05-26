class AuthHelper {
  static final upperCasePattern = RegExp('((.*[A-Z]){2})');
  static final lowerCasePattern = RegExp('((.*[a-z]){3})');
  static final specialCharsPattern = RegExp('((.*[!@#\$&*]){1})');
  static final digitsPattern = RegExp('((.*[0-9]){2})');
  static final lengthPattern = RegExp('.{8}');
  static final emailPattern = RegExp(
      '/^(([^<>()[]\\.,;:s@"]+(.[^<>()[]\\.,;:s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))');

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
