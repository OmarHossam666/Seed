import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_styles.dart';

class ForgetYourPasswordButton extends StatelessWidget {
  const ForgetYourPasswordButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primary,
        fixedSize: Size(177.96923828125.w, 32.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Text(text, style: AppStyles.nextButton),
    );
  }
}
