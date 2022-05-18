class AuthHelper {
  static var emailPattern = RegExp(
      '/^(([^<>()[]\\.,;:s@"]+(.[^<>()[]\\.,;:s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))');

  static isEmail(String email) {
    return emailPattern.allMatches(email).isNotEmpty;
  }

  static isPassword(String password) {
    List<bool> cases = [
      hasDigits(password),
      hasUpperCaseLetters(password),
      hasLength(password),
      hasSpecialCharacters(password),
    ];

    return cases.every((_case) => _case);
  }

  static hasUpperCaseLetters(String password, {int quantity = 2}) {
    final regex = RegExp('((.*[A-Z]){$quantity})');
    return regex.allMatches(password).isNotEmpty;
  }

  static hasSpecialCharacters(String password, {int quantity = 1}) {
    final regex = RegExp('((.*[!@#\$&*]){$quantity})');
    return regex.allMatches(password).isNotEmpty;
  }

  static hasDigits(String password, {int quantity = 2}) {
    final regex = RegExp('((.*[0-9]){$quantity})');
    return regex.allMatches(password).isNotEmpty;
  }

  static hasLowerCaseLetters(String password, {int quantity = 3}) {
    final regex = RegExp('((.*[a-z]){$quantity})');
    return regex.allMatches(password).isNotEmpty;
  }

  static hasLength(String password, {int length = 8}) {
    final regex = RegExp('.{$length}');
    return regex.allMatches(password).isNotEmpty;
  }
}
