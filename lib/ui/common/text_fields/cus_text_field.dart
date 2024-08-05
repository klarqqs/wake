import 'package:wake/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final TextInputFormatter? formatter;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int? maxLength;
  final Widget? suffixIcon;
  final Color? borderColor;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final bool shouldReadOnly;
  final bool enabled;
  final int? minLines;

  const CustomTextField({
    Key? key,
    this.label,
    this.keyboardType,
    this.obscureText = false,
    this.hintText,
    this.formatter,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.suffixIcon,
    this.borderColor,
    this.textEditingController,
    this.validator,
    this.shouldReadOnly = false,
    this.enabled = true,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: GoogleFonts.mynerve(
              color: const Color(0xffB9BCC8),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        SizedBox(height: 7.h),
        TextFormField(
          maxLines: minLines,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onTap: onTap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLength: obscureText ? null : maxLength,
          controller: textEditingController,
          cursorColor: kcPrimaryColor,
          keyboardType: keyboardType,
          readOnly: shouldReadOnly,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          inputFormatters: [
            formatter ?? FilteringTextInputFormatter.singleLineFormatter,
          ],
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            counterText: "",
            hintText: hintText,
            hintStyle: GoogleFonts.mynerve(
              color: Colors.white70,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(.03),
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 18.w,
            ),
            errorStyle: const TextStyle(fontSize: 12),
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kcPrimaryColor,
                width: 1.1.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white.withOpacity(.25),
                width: .55.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: .55.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: .55.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
          ),
        ),
      ],
    );
  }
}
