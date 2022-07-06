import 'package:get/get.dart';
import 'package:ownervet/utils/strings.dart';

class Validators {
  const Validators._();

  static String? validateEmpty(String? v) {
    if (v!.isEmpty) {
      return Strings.fieldCantBeEmpty;
    } else {
      return null;
    }
  }

  static String? validateTEmpty<T>(T? v) {
    if (v == null) {
      return Strings.fieldCantBeEmpty;
    } else {
      return null;
    }
  }
  static String? validatePhone(String? v) {
    if (v!.isEmpty) {
      return Strings.fieldCantBeEmpty;
    } else if (v.length != 10) {
      return "Please enter valid phone number";
    } else {
      return null;
    }
  }

  static String? validateEmail(String? v) {
    if (v!.isEmpty) {
      return Strings.emailCantBeEmpty;
    } else if (!GetUtils.isEmail(v)) {
      return Strings.enterValidEmail;
    } else {
      return null;
    }
  }

  /* static String? validatePhone(String? v) {
    if (v!.isEmpty) {
      return Strings.fieldCantBeEmpty;
    } else if (v.length != 10) {
      return Strings.enterValidNumber;
    } else {
      return null;
    }
  }*/

/*  static String? validateEmailPhone(String? v) {
    if (v!.isEmpty) {
      return Strings.fieldCantBeEmpty;
    } else if (GetUtils.isNumericOnly(v)) {
      return validatePhone(v);
    } else {
      return validateEmail(v);
    }
  }*/

  static String? validatePassword(String? v) {
    if (v!.isEmpty) {
      return Strings.passwordCantBeEmpty;
    } else if (!validateStructure(v)) {
      return Strings.passwordValidation;
    } else {
      return null;
    }
  }

  static String? validateUsername(String? v) {
    if (v!.isEmpty) {
      return Strings.fieldCantBeEmpty;
    } else if (!characterValidation(v)) {
      return Strings.enterValidUsername;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? v, String password) {
    if (v!.isEmpty || password.isEmpty) {
      return Strings.passwordCantBeEmpty;
    } else if (v.length < 8 || password.length < 8 || v != password) {
      return Strings.confirmPasswordValidation;
    } else {
      return null;
    }
  }

  static String? validateCheckbox({
    bool v = false,
    String error = Strings.checkboxValidation,
  }) {
    if (!v) {
      return error;
    } else {
      return null;
    }
  }

  static bool validateStructure(String value){
    if(value.length<8){
      return false;
    }else{
      return true;

    }
  }

  static bool characterValidation(String value){
    String  pattern = r'^[A-Za-z]+$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
