import 'package:wake/ui/common/app_colors.dart';
import 'package:wake/ui/common/auth/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:wake/ui/views/auth_signup/auth_signup_user_model.dart';

import '../../common/buttons/filled_btn.dart';
import '../../common/general/app_scaffold.dart';
import '../../common/general/resend_code.dart';

import '../../common/text_fields/pin_widget.dart';

import 'auth_verify_email_viewmodel.dart';

class AuthVerifyEmailView extends StackedView<AuthVerifyEmailViewModel> {
  final bool isSignUp;
  final SignupUserModel signupUserModel;

  const AuthVerifyEmailView({
    Key? key,
    required this.isSignUp,
    required this.signupUserModel,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthVerifyEmailViewModel viewModel,
    Widget? child,
  ) {
    return AppScaffold(
      hasSafeArea: false,
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      body: Column(
        children: [
          AuthHeader(
            title: isSignUp ? viewModel.title : "Ouch, recover password",
            description: isSignUp
                ? viewModel.description + signupUserModel.email
                : "A 4-digit code would be sent to your email address",
            color3: Colors.white.withOpacity(.1),
            onpressedBack: () => viewModel.navigationService.back(),
          ),
          _buildBody(viewModel, context),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildFooter(
              context,
              viewModel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(AuthVerifyEmailViewModel viewModel, BuildContext context) {
    return Expanded(
      child: Container(
        color: const Color.fromARGB(255, 15, 15, 15),
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 26.h),
              Row(
                children: [
                  Expanded(
                    child: PinTextField(
                      length: 4,
                      controller: viewModel.otpCodeTextEditingController,
                      onTextChanged: (value) {
                        if (value.length != 4) {
                          viewModel.buttonColor =
                              kcDarkGreyColor.withOpacity(.7);
                          viewModel.buttonTextColor =
                              kcDarkGreyColor.withOpacity(.7);
                          viewModel.notifyListeners();
                        } else {
                          viewModel.buttonColor = kcPrimaryColor;
                          viewModel.buttonTextColor = Colors.white;
                          viewModel.notifyListeners();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .15,
                  )
                ],
              ),
              SizedBox(height: 4.h),
              const ResendCodeWidget(),
              SizedBox(height: 26.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(
      BuildContext context, AuthVerifyEmailViewModel viewModel) {
    return Container(
      color: const Color.fromARGB(255, 15, 15, 15),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 8.h),
          FilledBtn(
            onPressed: () => {
              if (viewModel.otpCodeTextEditingController.text.length == 4)
                viewModel.onPressedVerify(signupUserModel, isSignUp),
            },
            text: isSignUp ? "Verify" : "Proceed",
            textColor: viewModel.buttonTextColor,
            backgroundColor: viewModel.buttonColor,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  @override
  AuthVerifyEmailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthVerifyEmailViewModel();
}
