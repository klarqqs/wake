import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wake/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../common/app_colors.dart';

class AuthSetPasswordViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  final String title = "Set a password",
      description = "Enter a password you can remember.";

  Color buttonColor = kcDarkGreyColor.withOpacity(.7);
  Color buttonTextColor = kcLightGrey.withOpacity(.7);

  final TextEditingController passwordTextEditingController =
          TextEditingController(),
      confirmPasswordTextEditingController = TextEditingController();

  void onPressedProceed(bool isSignUp) {
    navigationService.navigateToSuccessView(
      isSignUp: isSignUp,
    );
  }
}
