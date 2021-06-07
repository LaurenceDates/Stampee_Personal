//==============================
// Validator Component
// Version 0.1
// LastUpdate: Apr-24-2021
//==============================

class Validator {
  static bool email(String _email) {
    if (RegExp(r"^([!-~]+@[a-zA-Z0-9-_.]+.[a-zA-Z0-9-]+)*$").hasMatch(_email)) {
      return true;
    } else {
      return false;
    }
  }

  static bool password(String _password) {
    if (RegExp(r"(?=.*[a-zA-Z])(?=.*[0-9])[ -~]{6,}").hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }
}
