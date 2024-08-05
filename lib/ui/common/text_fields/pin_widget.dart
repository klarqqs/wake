import 'package:wake/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinTextField extends StatelessWidget {
  final Function(String)? onTextChanged;
  final Function()? onCancel;
  final Function(String)? onCompleted;
  final TextEditingController? controller;
  final bool isEnabled;
  final double? height;
  final double? width;
  final int length;
  final bool obscureText;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const PinTextField({
    super.key,
    this.onTextChanged,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.isEnabled = true,
    this.height,
    this.width,
    this.length = 4,
    this.onCancel,
    this.onCompleted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PinCodeTextField(
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          enablePinAutofill: true,
          controller: controller,
          autoDisposeControllers: false,
          enabled: isEnabled,
          validator: validator,
          obscureText: obscureText,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textStyle: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
          pinTheme: PinTheme(
            selectedFillColor: kcDarkGreyColor,
            activeFillColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(.3),
            inactiveFillColor: kcDarkGreyColor,
            selectedColor: kcPrimaryColor,
            inactiveColor: Colors.white.withOpacity(.25),
            activeColor: Colors.white.withOpacity(.25),
            fieldHeight: height ?? 62.0.w,
            fieldWidth: width ?? 62.0.w,
            borderRadius: BorderRadius.circular(12.r),
            shape: PinCodeFieldShape.box,
            borderWidth: .55.w,
            errorBorderWidth: .55.w,
            activeBorderWidth: .55.w,
            disabledBorderWidth: .55.w,
            inactiveBorderWidth: .55.w,
            selectedBorderWidth: 1.1.w,
          ),
          appContext: context,
          length: length,
          onCompleted: onCompleted,
          onChanged: onTextChanged!,
        ),
      ],
    );
  }
}
