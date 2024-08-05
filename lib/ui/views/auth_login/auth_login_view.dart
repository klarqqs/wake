import 'package:wake/app/app.router.dart';
import 'package:wake/ui/common/app_colors.dart';
import 'package:wake/ui/common/auth/auth_header.dart';
import 'package:wake/ui/common/general/validations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../common/buttons/filled_btn.dart';
import '../../common/general/app_scaffold.dart';
import '../../common/text_fields/cus_text_field.dart';

import 'auth_login_viewmodel.dart';

class AuthLoginView extends StackedView<AuthLoginViewModel> {
  AuthLoginView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder(
    BuildContext context,
    AuthLoginViewModel viewModel,
    Widget? child,
  ) {
    return AppScaffold(
      hasSafeArea: false,
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      body: Column(
        children: [
          AuthHeader(
            title: viewModel.title,
            description: viewModel.description,
            color2: kcMediumGrey,
            color3: kcMediumGrey,
            hasDots: false,
            onpressedBack: () => viewModel.navigationService.back(),
          ),
          _buildBody(viewModel),
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

  Widget _buildBody(AuthLoginViewModel viewModel) {
    return Expanded(
      child: Container(
        color: const Color.fromARGB(255, 15, 15, 15),
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 26.h),
                CustomTextField(
                  label: "Email Address",
                  hintText: "Enter email address",
                  textEditingController:
                      viewModel.emailAddressTextEditingController,
                  validator: (String? value) =>
                      Validation.validateEmail(value!),
                  onChanged: (val) {
                    if (!_formKey.currentState!.validate()) {
                      viewModel.buttonColor = kcDarkGreyColor.withOpacity(.7);
                      viewModel.buttonTextColor = kcLightGrey.withOpacity(.7);
                      viewModel.notifyListeners();
                    } else {
                      viewModel.buttonColor = kcPrimaryColor;
                      viewModel.buttonTextColor = Colors.white;
                      viewModel.notifyListeners();
                    }
                  },
                ),
                SizedBox(height: 18.h),
                CustomTextField(
                  label: "Password",
                  hintText: "Enter password",
                  textEditingController:
                      viewModel.passwordTextEditingController,
                  validator: (String? value) =>
                      Validation.validatePassword(value!),
                  onChanged: (val) {
                    if (!_formKey.currentState!.validate()) {
                      viewModel.buttonColor = kcDarkGreyColor.withOpacity(.7);
                      viewModel.buttonTextColor = kcLightGrey.withOpacity(.7);
                      viewModel.notifyListeners();
                    } else {
                      viewModel.buttonColor = kcPrimaryColor;
                      viewModel.buttonTextColor = Colors.white;
                      viewModel.notifyListeners();
                    }
                  },
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    textAlign: TextAlign.start,
                    TextSpan(
                      text: "Forgot password? ",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: [
                        TextSpan(
                          text: "Recover now",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: kcPrimaryColor,
                            letterSpacing: 0,
                            overflow: TextOverflow.ellipsis,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              viewModel.navigationService
                                  .navigateToAuthForgotPasswordView();
                            },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 26.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, AuthLoginViewModel viewModel) {
    return Container(
      color: const Color.fromARGB(255, 15, 15, 15),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 8.h),
          FilledBtn(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                viewModel.navigationService.navigateToHomeView();
              }
            },
            text: "Log in",
            textColor: viewModel.buttonTextColor,
            backgroundColor: viewModel.buttonColor,
          ),
          SizedBox(height: 10.h),
          Center(
            child: Text.rich(
              textAlign: TextAlign.start,
              TextSpan(
                text: "Don’t have an account? ",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0,
                  overflow: TextOverflow.ellipsis,
                ),
                children: [
                  TextSpan(
                    text: "Create account",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: kcPrimaryColor,
                      letterSpacing: 0,
                      overflow: TextOverflow.ellipsis,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        viewModel.navigationService.back();
                        viewModel.navigationService.replaceWithAuthSignupView();
                      },
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  @override
  AuthLoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthLoginViewModel();

  @override
  void onViewModelReady(AuthLoginViewModel viewModel) {
    viewModel.hardCoded();
    super.onViewModelReady(viewModel);
  }
}
