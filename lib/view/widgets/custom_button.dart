import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatefulWidget {
  final Widget? leading;
  final MainAxisAlignment? mainAxisAlignment;
  final double? width;
  final String label;
  final VoidCallback onPress;
  final EdgeInsets? leadingpadding;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final Color backgroundColor;
  final Color? borderColor;
  final TextStyle labelStyle;
  final LinearGradient? gradient;
  const MainButton({
    super.key,
    this.leading,
    required this.label,
    required this.onPress,
    this.leadingpadding,
    this.padding,
    required this.backgroundColor,
    required this.labelStyle,
    this.contentPadding,
    this.borderColor,
    this.width,
    this.gradient,
    this.mainAxisAlignment,
  });

  @override
  State<MainButton> createState() => MainyButtonState();
}

class MainyButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          EdgeInsets.symmetric(horizontal: 42.w, vertical: 35.h),
      child: GestureDetector(
        onTap: widget.onPress,
        child: Container(
            height: 50.h,
            width: widget.width ?? double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: widget.backgroundColor,
                gradient: widget.gradient,
                border: Border.all(
                    color: widget.borderColor ?? Colors.white, width: 0.6.sp)),
            child: widget.leading != null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment:
                        widget.mainAxisAlignment ?? MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: widget.leading ?? const SizedBox(),
                      ),
                      // Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.5.h),
                        child: Text(
                          widget.label,
                          textAlign: TextAlign.center,
                          style: widget.labelStyle,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.5.h),
                      child: Text(
                        widget.label,
                        style: widget.labelStyle,
                      ),
                    ),
                  )),
      ),
    );
  }
}
