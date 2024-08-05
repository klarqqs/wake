import 'package:wake/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlineBtn extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? textColor;

  const OutlineBtn({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 16.h),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          side: WidgetStateProperty.all(
            BorderSide(
              width: .55,
              color: kcDarkGreyColor.withOpacity(.35),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w900,
            color: kcPrimaryColorDark,
            letterSpacing: .2,
          ),
        ),
      ),
    );
  }
}
