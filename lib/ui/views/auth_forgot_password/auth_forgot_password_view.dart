import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:wake/ui/common/app_colors.dart';
import 'package:wake/ui/common/auth/auth_header.dart';
import 'package:wake/ui/common/buttons/filled_btn.dart';
import 'package:wake/ui/common/general/app_scaffold.dart';
import 'package:wake/ui/common/general/validations.dart';
import 'package:wake/ui/common/text_fields/cus_text_field.dart';

import 'auth_forgot_password_viewmodel.dart';

class AuthForgotPasswordView extends StackedView<AuthForgotPasswordViewModel> {
  AuthForgotPasswordView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder(
    BuildContext context,
    AuthForgotPasswordViewModel viewModel,
    Widget? child,
  ) {
    return AppScaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      hasSafeArea: false,
      body: Column(
        children: [
          AuthHeader(
            title: viewModel.title,
            description: viewModel.description,
            color2: Colors.white.withOpacity(.1),
            color3: Colors.white.withOpacity(.1),
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

  Widget _buildBody(AuthForgotPasswordViewModel viewModel) {
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
                SizedBox(height: 26.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(
      BuildContext context, AuthForgotPasswordViewModel viewModel) {
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
              }
            },
            text: "Send code",
            textColor: viewModel.buttonTextColor,
            backgroundColor: viewModel.buttonColor,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  @override
  AuthForgotPasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthForgotPasswordViewModel();
}
