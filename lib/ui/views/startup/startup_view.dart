import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xff161616),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const SizedBox(
            //   width: 16,
            //   height: 16,
            //   child: CircularProgressIndicator(
            //     color: Colors.white,
            //     strokeWidth: 6,
            //   ),
            // ),
            // const SizedBox(height: 24),
            Text(
              "/ˈɪmpʌls/",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.2,
                letterSpacing: 0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
