import 'package:wake/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wake/ui/views/auth_signup/auth_signup_user_model.dart';

import '../../../app/app.locator.dart';
import '../../common/app_colors.dart';

class AuthVerifyEmailViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  SignupUserModel? signupUserModel;

  final String title = "Verify your email",
      description = "Enter the 4-digit code sent to ";

  Color buttonColor = kcDarkGreyColor.withOpacity(.7);
  Color buttonTextColor = kcLightGrey.withOpacity(.7);

  final TextEditingController otpCodeTextEditingController =
      TextEditingController();

  void onPressedVerify(SignupUserModel signupUser, bool isSignUp) {
    signupUserModel = signupUser;
    navigationService.navigateToAuthSetPasswordView(
      isSignUp: isSignUp,
      signupUserModel: signupUser,
      otpCode: otpCodeTextEditingController.text,
    );
  }
}
