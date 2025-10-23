import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/core/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _navigateToSignUp() {
    context.push(AppRoutes.signup);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 4),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [
                  getVerticalSpacing(60),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 4),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: 0.8 + (0.2 * value),
                          child: child,
                        ),
                      );
                    },
                    child: SvgPicture.asset(AppAssets.splashScreenText),
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Image.asset(
                      AppAssets.appIcon,
                      width: 177.w,
                      height: 157.h,
                    ),
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 4),
                    curve: Curves.easeOutBack,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(32.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(120.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getVerticalSpacing(18),
                          // Email Field
                          _buildAnimatedField(
                            delay: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.email,
                                  style: AppStyles.inputLabel,
                                ),
                                getVerticalSpacing(5),
                                CustomTextField(
                                  controller: _emailController,
                                  hint: AppStrings.enterYourEmail,
                                  icon: AppAssets.emailIcon,
                                ),
                              ],
                            ),
                          ),
                          getVerticalSpacing(18),
                          // Password Field
                          _buildAnimatedField(
                            delay: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.password,
                                  style: AppStyles.inputLabel,
                                ),
                                getVerticalSpacing(5),
                                CustomTextField(
                                  controller: _passwordController,
                                  hint: AppStrings.enterYourPassword,
                                  icon: AppAssets.passwordIcon,
                                  obscureText: true,
                                ),
                              ],
                            ),
                          ),
                          getVerticalSpacing(16),
                          // Forgot Password
                          _buildAnimatedField(
                            delay: 600,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: RichText(
                                text: TextSpan(
                                  text: AppStrings.forgetYour,
                                  style: AppStyles.forgotPassword,
                                  children: [
                                    TextSpan(
                                      text: AppStrings.passwordQuestion,
                                      style: AppStyles.forgotPassword.copyWith(
                                        color: AppColors.background,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          getVerticalSpacing(82),
                          // Sign Up Link
                          _buildAnimatedField(
                            delay: 800,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: const Divider()),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        text: AppStrings.dontHaveAnAccount,
                                        style: AppStyles.signUpText,
                                        children: [
                                          TextSpan(
                                            text:
                                                ' ${AppStrings.signUp.toLowerCase()}',
                                            style: AppStyles.signUpLink
                                                .copyWith(
                                                  color: AppColors.background,
                                                ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = _navigateToSignUp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(child: const Divider()),
                                ],
                              ),
                            ),
                          ),
                          getVerticalSpacing(60),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedField({required int delay, required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(30 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
