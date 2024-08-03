import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../constants/app_colors.dart';

class FilledMiniBtn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final bool? isEnabled;
  final Function()? onPressed;

  const FilledMiniBtn({
    super.key,
    required this.text,
    this.textColor,
    this.onPressed,
    this.backgroundColor = const Color(0xff8D60F3),
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12),
          ),
          backgroundColor: WidgetStateProperty.all(
              isEnabled == false ? const Color(0xff8D60F3) : backgroundColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        onPressed: isEnabled == false ? () {} : onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: -.15,
            ),
          ),
        ),
      ),
    );
  }
}
