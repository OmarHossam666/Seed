import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/core/widgets/enhanced_text_field.dart';
import 'package:seed/features/authentication/presentation/widgets/forget_your_password_button.dart';

class ForgetYourPasswordScreen extends StatefulWidget {
  const ForgetYourPasswordScreen({super.key});

  @override
  State<ForgetYourPasswordScreen> createState() =>
      _ForgetYourPasswordScreenState();
}

class _ForgetYourPasswordScreenState extends State<ForgetYourPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Image.asset(AppAssets.backButtonIcon),
                  ),
                  Text(
                    AppStrings.forgotYourPassword,
                    style: AppStyles.title,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            getVerticalSpacing(40),
            Image.asset(
              AppAssets.forgetYourPasswordIcon,
              width: 125.w,
              height: 125.h,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(150.r),
                    topRight: Radius.circular(150.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 48.r, vertical: 32.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hint: AppStrings.enterYourEmail,
                      icon: AppAssets.emailIcon,
                    ),
                    getVerticalSpacing(50),
                    ForgetYourPasswordButton(
                      text: AppStrings.sendEmail,
                      onPressed: () =>
                          context.push(AppRoutes.createNewPassword),
                    ),
                    getVerticalSpacing(15),
                    ForgetYourPasswordButton(
                      text: AppStrings.resendEmail,
                      onPressed: () =>
                          context.push(AppRoutes.createNewPassword),
                    ),
                    getVerticalSpacing(40),
                    Image.asset(
                      AppAssets.greenCheckMark,
                      width: 50.w,
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
