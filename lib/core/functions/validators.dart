abstract class Validators {
  //email validator
  static String? emailValidator(String? value) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value!)) {
      return null;
    } else {
      return "please enter valid email";
    }
  }

  //Password validator
  static String? passwordValidator(String? value) {
    if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(value!)) {
      return null;
    } else {
      return "please enter valid password";
    }
  }

  //repaeat Password validator
  static String? repeatPasswordValidaotr({String? value, String? password}) {
    if (value != password) {
      return 'not match password';
    } else {
      return null;
    }
  }

  //name validator
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter name';
    } else if (value.length < 3 || value.length > 20) {
      return 'Enter Name between 3 to 20 characters';
    } else {
      return null;
    }
  }
}
