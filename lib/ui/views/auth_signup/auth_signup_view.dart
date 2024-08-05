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

import 'auth_signup_viewmodel.dart';

class AuthSignupView extends StackedView<AuthSignupViewModel> {
  AuthSignupView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder(
    BuildContext context,
    AuthSignupViewModel viewModel,
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
            color2: Colors.white.withOpacity(.1),
            color3: Colors.white.withOpacity(.1),
            hasBackButton: false,
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

  Widget _buildBody(AuthSignupViewModel viewModel) {
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
                  label: "First name",
                  hintText: "Enter first name",
                  textEditingController:
                      viewModel.firstNameTextEditingController,
                  validator: Validation.validateString,
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
                  label: "Last name",
                  hintText: "Enter last name",
                  textEditingController:
                      viewModel.lastNameTextEditingController,
                  validator: Validation.validateString,
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
                // SizedBox(height: 18.h),
                // CustomTextField(
                //   label: "Phone Number",
                //   hintText: "Enter phone number",
                //   textEditingController:
                //       viewModel.phoneNumberTextEditingController,
                //   validator: (String? value) =>
                //       Validation.validatePhoneNumber(value!),
                //   onChanged: (val) {
                //     if (!_formKey.currentState!.validate()) {
                //       viewModel.buttonColor = kcDarkGreyColor.withOpacity(.7);
                //       viewModel.buttonTextColor = kcLightGrey.withOpacity(.7);
                //       viewModel.notifyListeners();
                //     } else {
                //       viewModel.buttonColor = kcPrimaryColor;
                //       viewModel.buttonTextColor = Colors.white;
                //       viewModel.notifyListeners();
                //     }
                //   },
                // ),
                SizedBox(height: 26.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, AuthSignupViewModel viewModel) {
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
                viewModel.onPressedProceed();
              } else {}
            },
            text: "Proceed",
            textColor: viewModel.buttonTextColor,
            backgroundColor: viewModel.buttonColor,
          ),
          SizedBox(height: 10.h),
          Center(
            child: Text.rich(
              textAlign: TextAlign.end,
              TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0,
                  overflow: TextOverflow.ellipsis,
                ),
                children: [
                  TextSpan(
                    text: " Log in",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w900,
                      color: kcPrimaryColor,
                      letterSpacing: 0,
                      overflow: TextOverflow.ellipsis,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        viewModel.navigationService.navigateToAuthLoginView();
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
  AuthSignupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthSignupViewModel();
}
