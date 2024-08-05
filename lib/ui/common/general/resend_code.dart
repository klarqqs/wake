import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

class ResendCodeWidget extends StatefulWidget {
  const ResendCodeWidget({super.key});

  @override
  ResendCodeWidgetState createState() => ResendCodeWidgetState();
}

class ResendCodeWidgetState extends State<ResendCodeWidget> {
  Timer? _timer;
  int _start = 59;
  bool _isButtonEnabled = false;

  void startTimer() {
    _start = 59;
    _isButtonEnabled = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          _isButtonEnabled = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _isButtonEnabled
            ? InkWell(
                borderRadius: BorderRadius.circular(100.0),
                onTap: () => startTimer(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: Colors.white.withOpacity(.25),
                      width: 1.0.w,
                    ),
                  ),
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                      color: kcPrimaryColor,
                      letterSpacing: 0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  border: Border.all(
                    color: Colors.white.withOpacity(.25),
                    width: 1.0.w,
                  ),
                ),
                child: Center(
                  child: Text.rich(
                    textAlign: TextAlign.start,
                    TextSpan(
                      text: "Resend code in ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 0,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: [
                        TextSpan(
                          text: "${_start + 1}s",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: kcPrimaryColor,
                            letterSpacing: 0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
        const SizedBox(height: 20),
        const Spacer(),
      ],
    );
  }
}
