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
      child: InkWell(
        // style: ButtonStyle(
        //   padding: WidgetStateProperty.all(
        //     const EdgeInsets.symmetric(vertical: 10),
        //   ),
        //   backgroundColor: WidgetStateProperty.all(
        //     // isEnabled == false ?
        //     Colors.transparent,
        //     // : backgroundColor
        //   ),
        //   shape: WidgetStateProperty.all(
        //     RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(6),
        //     ),
        //   ),
        // ),
        onTap: isEnabled == false ? () {} : onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
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
