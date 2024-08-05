import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Validation {
  static String getFormattedTimeDate(DateTime date) {
    var formatter = DateFormat('dd MMM yyyy - hh:mm:ss');
    final dateFormatted = formatter.format(date);
    return dateFormatted;
  }

  static String getPostFormattedDate(String date,
      [bool isWithoutTime = false]) {
    try {
      DateTime formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(date);
      var formatter = isWithoutTime
          ? DateFormat('dd-MMM-yyyy')
          : DateFormat('dd-MMM-yyyy HH:mm:ss');
      final resultDate = formatter.format(formattedDate);
      return resultDate;
    } catch (e) {
      return date;
    }
  }

  static String getFormattedTime(String date) {
    try {
      DateTime formattedDate = DateTime.parse(date);
      String formattedTime = DateFormat.jm().format(formattedDate);
      // print(formattedTime);
      return formattedTime;
    } catch (e) {
      return date;
    }
  }

  static int getFormattedAmount(String amount) {
    final amt =
        amount.replaceAll(RegExp(r'N\s|\,|\.00|NGN|USD|GBP|EUR|\s+'), "");
    return int.parse(amt);
  }

  static String removeCurrencySymbol(String amount) {
    final amt = amount.replaceAll(RegExp(r'N\s|NGN|USD|GBP|EUR|\s+|\,'), "");
    return amt;
  }

  static double getFormattedAmountDouble(String amount) {
    final amt = amount.replaceAll(RegExp(r'N\s|\,|NGN|USD|GBP|EUR|\s+'), "");
    return double.parse(amt);
  }

  static bool isPasswordLengthCompliant(String password) {
    return password.length >= GeneralLimits.passwordLength ? true : false;
  }

  static bool containsUpperCase(String password) {
    return password.contains(RegExp(r'[A-Z]')) ? true : false;
  }

  static bool containsLowerCase(String password) {
    return password.contains(RegExp(r'[a-z]')) ? true : false;
  }

  static bool containsDigits(String password) {
    return password.contains(RegExp(r'.*\d.*')) ? true : false;
  }

  static bool containsSpecialCharater(String password) {
    return password.contains(RegExp(r'\W')) ? true : false;
  }

  static String? validateConfirmPassword(
      String newPassword, String confirmNewPassword) {
    if (confirmNewPassword.isEmpty) {
      return "Passwords cannot be empty";
    }

    if (newPassword != confirmNewPassword) {
      return "Passwords do not match";
    }

    // if (!confirmNewPassword.contains(RegExp(r'[A-Z]'))) {
    //   return "Password must contain upper case";
    // }

    // if (!newPassword.contains(RegExp(r'\W'))) {
    //   return "Password must contain a symbol";
    // }

    // if (!newPassword.contains(RegExp(r'[\d]'))) {
    //   return "Password must contain a number";
    // }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Password cannot be empty";
    }

    if (password.length < GeneralLimits.passwordLength) {
      return "Password length must be ${GeneralLimits.passwordLength} characters";
    }

    // if (!password.contains(RegExp(r'[A-Z]'))) {
    //   return "Password must contain upper case";
    // }

    // if (!password.contains(RegExp(r'\W'))) {
    //   return "Password must contain a symbol";
    // }

    // if (!password.contains(RegExp(r'[\d]'))) {
    //   return "Password must contain a number";
    // }
    return null;
  }

  static String? checkNewPassword(String currentPassword, String newPassword) {
    if (newPassword.trim().isEmpty) {
      return "Passwords cannot be empty";
    }

    if (newPassword.trim() != currentPassword.trim()) {
      if (currentPassword.length < GeneralLimits.passwordLength) {
        return "Password length must be ${GeneralLimits.passwordLength} characters";
      }

      // if (!currentPassword.contains(RegExp(r'[A-Z]'))) {
      //   return "Password must contain upper case";
      // }

      // if (!currentPassword.contains(RegExp(r'\W'))) {
      //   return "Password must contain a symbol";
      // }

      // if (!currentPassword.contains(RegExp(r'[\d]'))) {
      //   return "Password must contain a number";
      // }
    }
    if (newPassword.trim() != currentPassword.trim()) {
      return "Confirm password must be match with password";
    }
    return null;
  }

  static String removeCommaFromString(String amount) {
    String amountString = amount.replaceAll(',', '');
    return amountString;
  }

  static String checkUserInput(String inputName, String value, int minLength) {
    if (value.trim().isEmpty) {
      return '$inputName can not be empty';
    } else if (value.trim().length < minLength) {
      return '$inputName should be a minimum of $minLength characters';
    }
    return "";
  }

//  todo: Input Validators
  static bool isFieldEmpty(String fieldValue) => fieldValue.isEmpty;

  static String? validateName(String value) {
    if (value.trim().isEmpty) return 'Please this field is required';
    final RegExp nameExp = RegExp(r'^[A-za-z. ]+$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  static String? validateEmail(String value) {
    if (value.trim().isEmpty) return 'Please this field is required';
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validateNumber(String value) {
    if (value.trim().isEmpty) return 'Please this field is required';
    final RegExp nameExp = RegExp(r'^[-0-9 ]+$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Please enter only numeric characters.';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value) {
    if (value.trim().isEmpty) return 'Please this field is required';
    final RegExp nameExp = RegExp(r'^(?:[+0])?[0-9]{10}$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Please enter a valid phone number.';
    }
    if (value.trim().length != 11) {
      return 'Field must be of 11 digits';
    } else {
      return null;
    }
  }

  static String? validateAccountNumber(String value) {
    if (value.trim().isEmpty) return 'Please this field is required';
    if (value.trim().length != 10) {
      return 'Field must be of 10 digits';
    } else {
      return null;
    }
  }

  static String? validateString(dynamic value) {
    if (value.toString().trim().isEmpty) {
      return 'Please this field is required';
    } else {
      return null;
    }
  }

  static bool spinnerVaidation(
      BuildContext context, TextEditingController controller, String text) {
    if (controller.text.isEmpty || controller.text == "") {
      return false;
    } else {
      return true;
    }
  }

  static String? pinValidator(BuildContext context, String text) {
    int trimmedTextLength = text.trim().length;
    if (text.trim().isEmpty) return 'Please this field is required';
    if (trimmedTextLength < 4 || trimmedTextLength > 4) {
      return "Pin field must be 4 digits";
    }
    return null;
  }

  static String? newPinValidator(
      BuildContext context, String oldPin, String newPin) {
    int trimmedTextLength = oldPin.trim().length;
    if (newPin.trim().isEmpty) return 'Please this field is required';
    if (trimmedTextLength < 4 || trimmedTextLength > 4) {
      return "Pin field must be 4 digits";
    }
    if (oldPin.trim() == newPin.trim()) {
      return "Your new pin must be different from your current pin.";
    }
    return null;
  }

  static String? confirmNewPinValidator(
      BuildContext context, String confirmPin, String currentPin) {
    log("ref $confirmPin and $currentPin");
    int trimmedTextLength = confirmPin.trim().length;

    if (confirmPin.trim().isEmpty) return 'Please this field is required';
    if (trimmedTextLength < 4 || trimmedTextLength > 4) {
      return "Pin field must be 4 digits";
    }
    if (confirmPin.trim() != currentPin.trim()) {
      return "Your new pin doesn't correspond";
    }
    if (confirmPin.trim() == currentPin.trim()) {
      return null;
    }
    return null;
  }

  static String? accountNumber(String controller) {
    String trimmed = controller.trim();
    if (trimmed.length < 10) {
      return "Account number must be 10 digits";
    }
    return null;
  }
}

class TextInputLimits {
  static const int usernameLength = 30;
  static const int emailLength = 50;
  static const int passwordLength = 25;
  static const int nameLength = 20;
  static const int phoneLength = 11;
  static const int bvnLength = 11;
  static const int securityQuestionAnswerLength = 11;
  static const int otpLength = 6;
  static const int amountLength = 7;
  static const int pinLength = 4;
}

class TextInputMinLimits {
  static const int nameLength = 3;
  static const int passwordLength = 5;
}

class GeneralLimits {
  static const int passwordLength = 8;
}

class Pay4MeConstants {
  static const int pay4MeEligibleAmount = 50000;
}
