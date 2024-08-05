import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wake/app/app.locator.dart';
import 'package:wake/app/app.router.dart';
import 'package:wake/ui/common/app_colors.dart';
import 'package:wake/ui/views/auth_signup/auth_signup_user_model.dart';

class AuthForgotPasswordViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  SignupUserModel? signupUserModel;

  final String title = "Ouch, recover password",
      description = "A 4-digit code would be sent to your email address";

  Color buttonColor = kcDarkGreyColor.withOpacity(.7);
  Color buttonTextColor = kcLightGrey.withOpacity(.7);

  final TextEditingController emailAddressTextEditingController =
      TextEditingController();

  void onPressedProceed() {
    signupUserModel = SignupUserModel(
      firstName: "",
      lastName: "",
      email: emailAddressTextEditingController.text,
      phone: "",
    );
    navigationService.navigateToAuthVerifyEmailView(
      isSignUp: false,
      signupUserModel: signupUserModel!,
    );
  }
}
