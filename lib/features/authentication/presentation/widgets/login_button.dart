import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/routes/app_routes.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          context.pushReplacement(AppRoutes.home);
        },
        style: TextButton.styleFrom(
          backgroundColor: AppColors.white,
          fixedSize: Size(133.w, 36.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
        ),
        child: Text(AppStrings.login, style: AppStyles.loginButton),
      ),
    );
  }
}
