import 'package:wake/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigation;
  final bool? isModelBusy;
  final PreferredSizeWidget? appbar;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final Function()? omFloatingActionBtnPressed;
  final Key? scaffoldKey;
  final Widget? drawer;
  final bool? shouldShowFloatingBtn;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool hasSafeArea;

  const AppScaffold({
    super.key,
    required this.body,
    this.bottomNavigation,
    this.isModelBusy,
    this.appbar,
    this.floatingActionButton,
    this.omFloatingActionBtnPressed,
    this.shouldShowFloatingBtn,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.scaffoldKey,
    this.drawer,
    this.hasSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(),
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        appBar: appbar,
        bottomNavigationBar: bottomNavigation,
        extendBodyBehindAppBar: true,
        body: hasSafeArea
            ? SafeArea(
                child: Stack(
                  children: [
                    body,
                    if (isModelBusy == true) ...[const Loader()]
                  ],
                ),
              )
            : Stack(
                children: [
                  body,
                  if (isModelBusy == true) ...[const Loader()]
                ],
              ),
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButton:
            shouldShowFloatingBtn == false ? Container() : floatingActionButton,
        drawer: drawer,
      ),
    );
  }

  void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.7),
      body: Center(
        child: Container(
          width: 50.0.h,
          height: 50.0.h,
          alignment: Alignment.center,
          child: const LoadingIndicator(
              indicatorType: Indicator.ballRotateChase,
              colors: [kcPrimaryColor],
              strokeWidth: 5.0,
              pathBackgroundColor: Colors.black),
        ),
      ),
    );
  }
}
