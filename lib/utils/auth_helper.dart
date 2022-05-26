class AuthHelper {
  static get upperCasePattern => RegExp('((.*[A-Z]){2})');
  static get lowerCasePattern => RegExp('((.*[a-z]){3})');
  static get specialCharsPattern => RegExp('((.*[!@#\$&*]){1})');
  static get digitsPattern => RegExp('((.*[0-9]){2})');
  static get lengthPattern => RegExp('.{8}');

  static final emailPattern = RegExp(
      '/^(([^<>()[]\\.,;:s@"]+(.[^<>()[]\\.,;:s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))');

  static isEmail(String email) {
    return emailPattern.allMatches(email).isNotEmpty;
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
