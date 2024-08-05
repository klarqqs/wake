import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wake/ui/common/app_colors.dart';

class FilledBtn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final bool? isEnabled;
  final Function()? onPressed;
  final Color? borderColor;
  final double borderWidth;

  const FilledBtn({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.onPressed,
    this.backgroundColor,
    this.isEnabled = true,
    this.borderColor,
    this.borderWidth = .55,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 16.h),
          ),
          side: WidgetStateProperty.all(
            BorderSide(
              color: borderColor ?? kcVeryLightGrey.withOpacity(.15),
              width: borderWidth,
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
            backgroundColor ??
                (isEnabled == false ? kcPrimaryColor : kcPrimaryColor),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(Colors.transparent),
        ),
        onPressed: isEnabled == false ? () {} : onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: .2,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
