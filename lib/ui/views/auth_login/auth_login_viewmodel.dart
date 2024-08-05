import 'package:wake/app/app.router.dart';
import 'package:wake/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class AuthLoginViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final String title = "Hi there! 🙃",
      description = "Let’s get a clearer picture of how much you’re spending";

  Color buttonColor = kcDarkGreyColor.withOpacity(.7);
  Color buttonTextColor = kcLightGrey.withOpacity(.7);

  final TextEditingController emailAddressTextEditingController =
          TextEditingController(text: "kol@xyz.com"),
      passwordTextEditingController =
          TextEditingController(text: "kol@xyz.com");

  void hardCoded() {
    emailAddressTextEditingController.text = "kol@xyz.com";
    passwordTextEditingController.text = "password";
    buttonColor = kcPrimaryColor;
    buttonTextColor = Colors.white;

    notifyListeners();
  }

  void onPressedProceed() {
    navigationService.navigateToAuthForgotPasswordView();
  }
}
