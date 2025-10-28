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

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
                      controller: _newPasswordController,
                      hint: AppStrings.enterYourPassword,
                      icon: AppAssets.passwordIcon,
                    ),
                    getVerticalSpacing(30),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hint: AppStrings.reenterYourPassword,
                      icon: AppAssets.passwordIcon,
                    ),
                    getVerticalSpacing(40),
                    ForgetYourPasswordButton(
                      text: AppStrings.done,
                      onPressed: () => context.pushReplacement(AppRoutes.login),
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
