import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openai_client/utils/style/app_theme.dart';

class AuthKey extends StatelessWidget {
  const AuthKey({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
