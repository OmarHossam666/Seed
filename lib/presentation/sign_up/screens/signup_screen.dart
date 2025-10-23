import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/core/widgets/custom_next_button.dart';
import 'package:seed/core/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String? selectedActivity;

  void _navigateToTest() {
    context.push(AppRoutes.test);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _educationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and title
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 4),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, -20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Image.asset(
                      AppAssets.backButtonIcon,
                      width: 50.w,
                      height: 50.h,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.signUp,
                      style: AppStyles.title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  getHorizontalSpacing(50),
                ],
              ),
            ),
            // Profile Icon
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 4),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
                );
              },
              child: Center(
                child: Image.asset(
                  AppAssets.signupIcon,
                  width: 150.w,
                  height: 150.h,
                ),
              ),
            ),
            // Form Container
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.r),
                        topRight: Radius.circular(100.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          children: [
                            getVerticalSpacing(20),
                            // Name Field
                            _buildAnimatedField(
                              delay: 200,
                              child: CustomTextField(
                                controller: _nameController,
                                hint: AppStrings.enterYourName,
                                icon: AppAssets.nameIcon,
                              ),
                            ),
                            getVerticalSpacing(20),
                            // Age Field
                            _buildAnimatedField(
                              delay: 300,
                              child: CustomTextField(
                                controller: _ageController,
                                hint: AppStrings.enterYourAge,
                                icon: AppAssets.ageIcon,
                              ),
                            ),
                            getVerticalSpacing(20),
                            // Email Field
                            _buildAnimatedField(
                              delay: 400,
                              child: CustomTextField(
                                controller: _emailController,
                                hint: AppStrings.enterYourEmail,
                                icon: AppAssets.emailIcon,
                              ),
                            ),
                            getVerticalSpacing(20),
                            // Password Field
                            _buildAnimatedField(
                              delay: 500,
                              child: CustomTextField(
                                controller: _passwordController,
                                hint: AppStrings.enterYourPassword,
                                icon: AppAssets.passwordIcon,
                                obscureText: true,
                              ),
                            ),
                            getVerticalSpacing(20),
                            // Education Field
                            _buildAnimatedField(
                              delay: 600,
                              child: CustomTextField(
                                controller: _educationController,
                                hint: AppStrings.education,
                                icon: AppAssets.educationIcon,
                              ),
                            ),
                            getVerticalSpacing(20),
                            // Activities Dropdown
                            _buildAnimatedField(
                              delay: 700,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColors.textFieldBorder,
                                    width: 2.w,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selectedActivity ??
                                            AppStrings
                                                .pickYourFavoriteActivities,
                                        style: AppStyles.dropdownText,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.primary,
                                      size: 24.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            getVerticalSpacing(40),
                            // Next Button
                            _buildAnimatedField(
                              delay: 800,
                              child: CustomNextButton(
                                onPressed: _navigateToTest,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
