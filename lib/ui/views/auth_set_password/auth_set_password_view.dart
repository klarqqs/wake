import 'package:wake/ui/common/app_colors.dart';
import 'package:wake/ui/common/auth/auth_header.dart';
import 'package:wake/ui/common/general/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:wake/ui/views/auth_signup/auth_signup_user_model.dart';

import '../../common/buttons/filled_btn.dart';
import '../../common/general/app_scaffold.dart';
import '../../common/text_fields/cus_text_field.dart';

import 'auth_set_password_viewmodel.dart';

class AuthSetPasswordView extends StackedView<AuthSetPasswordViewModel> {
  final bool isSignUp;
  final SignupUserModel signupUserModel;
  final String otpCode;

  AuthSetPasswordView({
    Key? key,
    required this.isSignUp,
    required this.signupUserModel,
    required this.otpCode,
  }) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder(
    BuildContext context,
    AuthSetPasswordViewModel viewModel,
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

  Widget _buildBody(AuthSetPasswordViewModel viewModel) {
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
                  label: "Password",
                  hintText: "Enter password",
                  textEditingController:
                      viewModel.passwordTextEditingController,
                  validator: (String? val) => Validation.validatePassword(val!),
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
                  label: "Confirm Password",
                  hintText: "Enter password",
                  textEditingController:
                      viewModel.confirmPasswordTextEditingController,
                  validator: (String? val) =>
                      Validation.validateConfirmPassword(
                          val!, viewModel.passwordTextEditingController.text),
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
                SizedBox(height: 26.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(
      BuildContext context, AuthSetPasswordViewModel viewModel) {
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
                viewModel.onPressedProceed(isSignUp);
              }
            },
            text: isSignUp ? "Set up" : "Recover",
            textColor: viewModel.buttonTextColor,
            backgroundColor: viewModel.buttonColor,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  @override
  AuthSetPasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthSetPasswordViewModel();
}
