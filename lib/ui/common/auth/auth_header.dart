import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String description;
  final Color color1;
  final Color color2;
  final Color color3;
  final bool hasDots;
  final bool hasBackButton;
  final void Function()? onpressedBack;

  const AuthHeader({
    super.key,
    required this.title,
    required this.description,
    this.color1 = Colors.white,
    this.color2 = Colors.white,
    this.color3 = Colors.white,
    this.hasDots = true,
    this.hasBackButton = true,
    this.onpressedBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4.0),
      decoration: const BoxDecoration(
        color: Color(0xff161616),
        border: Border(
          bottom: BorderSide(
            color: kcLightGrey,
            width: .1,
          ),
        ),
      ),
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 54.h),
              hasBackButton
                  ? InkWell(
                      onTap: onpressedBack,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        child: SvgPicture.asset(
                          "assets/svgs/back.svg",
                          // ignore: deprecated_member_use
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.2,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(.7),
                        letterSpacing: 0,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
              // hasDots
              //     ? Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 14.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: List.generate(
              //             3,
              //             (index) => _buildDot(
              //               index,
              //               context,
              //               index == 0
              //                   ? color1
              //                   : index == 1
              //                       ? color2
              //                       : color3,
              //             ),
              //           ),
              //         ),
              //       )
              //     : const SizedBox.shrink(),
              // SizedBox(height: 10.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDot(
    int index,
    BuildContext context,
    Color color,
  ) {
    return Expanded(
      flex: 1,
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: 4.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}
