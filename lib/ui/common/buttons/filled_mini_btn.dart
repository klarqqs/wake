import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wake/ui/common/app_colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../constants/app_colors.dart';

class TextMiniBtn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final bool? isEnabled;
  final Function()? onPressed;

  const TextMiniBtn({
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

class MiniOptionTextBtn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final bool? isEnabled;
  final String? assetName;
  final Function()? onPressed;

  const MiniOptionTextBtn({
    super.key,
    required this.text,
    this.textColor,
    this.onPressed,
    this.backgroundColor = const Color(0xff8D60F3),
    this.isEnabled = true,
    this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: isEnabled == false ? () {} : onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                assetName!,
                height: 16,
                color: Colors.white.withOpacity(.7),
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilledMiniBtn2 extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final bool? isEnabled;
  final Function()? onPressed;

  const FilledMiniBtn2({
    super.key,
    required this.text,
    this.textColor,
    this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10),
          ),
          backgroundColor: WidgetStateProperty.all(
              isEnabled == false ? Colors.transparent : backgroundColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.pressed)) {
              return kcPrimaryColor.withOpacity(.05);
            }
            if (states.contains(WidgetState.hovered)) {
              return kcPrimaryColor.withOpacity(.05);
            }
            return null;
          }),
        ),
        onPressed: isEnabled == false ? () {} : onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 6.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   'assets/svgs/import.svg',
              //   height: 16,
              //   color: kcPrimaryColor,
              // ),
              // const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  color: kcPrimaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
