// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderradius;
  final bool? isBorder;
  final Widget child;
  final Color? backgroundColor;
  const GradientContainer(
      {super.key,
      this.height,
      this.width,
      required this.child,
      this.borderradius,
      this.backgroundColor,
      this.isBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      width: width ?? null,
      decoration: BoxDecoration(
        gradient: isBorder != null && isBorder == true
            ? const LinearGradient(colors: [
                Colors.red,
                Colors.orange,
              ])
            : null,
        color: isBorder != null && isBorder == false
            ? Colors.black.withOpacity(0.2)
            : null,
        borderRadius: BorderRadius.circular(borderradius ?? 0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(borderradius ?? 0),
          ),
          child: child,
        ),
      ),
    );
  }
}
