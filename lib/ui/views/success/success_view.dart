import 'package:wake/app/app.router.dart';
import 'package:wake/ui/common/app_colors.dart';
import 'package:wake/ui/common/buttons/filled_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'success_viewmodel.dart';

class SuccessView extends StackedView<SuccessViewModel> {
  final bool isSignUp;
  const SuccessView({
    Key? key,
    required this.isSignUp,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SuccessViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .05),
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

  Widget _buildBody(SuccessViewModel viewModel) {
    return Column(
      children: [
        SvgPicture.asset("assets/svgs/successcheck.svg"),
        SizedBox(height: 18.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  isSignUp ? "Account created" : "Password recovered",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    color: kcPrimaryColor,
                    height: 1.2,
                    letterSpacing: .2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                isSignUp
                    ? "You have successfully created an account, log in and start managing your online subscription."
                    : "Log in now and continue your practice, exams are close.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(.8),
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, SuccessViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 8.h),
          FilledBtn(
            onPressed: () {
              isSignUp
                  ? viewModel.navigationService.navigateToHomeView()
                  : viewModel.navigationService.navigateToAuthLoginView();
            },
            text: isSignUp ? "Dismiss" : "Log in now",
            textColor: Colors.white,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  @override
  SuccessViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SuccessViewModel();
}
