import 'package:wake/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wake/ui/views/auth_signup/auth_signup_user_model.dart';

import '../../../app/app.locator.dart';
import '../../common/app_colors.dart';

class AuthSignupViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  SignupUserModel? signupUserModel;

  final String title = "Tell us about yourself",
      description = "Enter your correct details";

  Color buttonColor = kcDarkGreyColor.withOpacity(.7);
  Color buttonTextColor = kcLightGrey.withOpacity(.7);

  final TextEditingController firstNameTextEditingController =
          TextEditingController(),
      lastNameTextEditingController = TextEditingController(),
      emailAddressTextEditingController = TextEditingController(),
      phoneNumberTextEditingController = TextEditingController();

  void onPressedProceed() {
    signupUserModel = SignupUserModel(
      firstName: firstNameTextEditingController.text,
      lastName: lastNameTextEditingController.text,
      email: emailAddressTextEditingController.text,
      phone: phoneNumberTextEditingController.text,
    );
    navigationService.navigateToAuthVerifyEmailView(
      isSignUp: true,
      signupUserModel: signupUserModel!,
    );
  }
}
