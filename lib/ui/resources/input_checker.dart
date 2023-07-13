
/// Input validation class
class InputChecker {

  static final InputChecker _singleton = InputChecker._internal();

  factory InputChecker() {
    return _singleton;
  }

  InputChecker._internal();

  static bool passwordValidator(String password){
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#\$&*~+.-]).{8,}$');
    return regex.hasMatch(password);
  }

  static bool isEmail(String email){
    RegExp regExp = RegExp(r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+");
    return regExp.hasMatch(email);
  }

  static bool isValidUsername(String username){
    RegExp regExp = RegExp(r"^(?=[a-zA-Z\d._]{6,20}$)(?!.*[_.]{2})[^_.].*[^_.]$");
    return regExp.hasMatch(username);
  }

  static bool isValidUrl(String string){
    RegExp regExp = RegExp(r"^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)$");
    return regExp.hasMatch(string);
  }

}