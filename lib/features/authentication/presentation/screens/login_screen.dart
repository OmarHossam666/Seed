import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/di/dependency_injection.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/core/utils/validators.dart';
import 'package:seed/core/widgets/enhanced_text_field.dart';
import 'package:seed/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:seed/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:seed/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:seed/features/authentication/presentation/widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
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
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _navigateToSignUp() {
    if (mounted) {
      context.push(AppRoutes.signup);
    }
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      // Trigger login event
      context.read<AuthenticationBloc>().add(
        LoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthenticationBloc>(),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            context.pushReplacement(AppRoutes.test);
          } else if (state is AuthenticationError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthenticationLoading;

          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              getVerticalSpacing(60),
                              // Logo
                              SvgPicture.asset(AppAssets.splashScreenText),
                              getVerticalSpacing(20),
                              // App Icon
                              Image.asset(
                                AppAssets.appIcon,
                                width: 177.w,
                                height: 157.h,
                              ),
                              getVerticalSpacing(20),
                              // Login Form Container
                              Container(
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
                                    _buildEmailField(context),
                                    getVerticalSpacing(18),
                                    // Password Field
                                    _buildPasswordField(context),
                                    getVerticalSpacing(16),
                                    // Forgot Password
                                    _buildForgotPassword(),
                                    getVerticalSpacing(23),
                                    const LoginButton(),
                                    getVerticalSpacing(23),
                                    // Sign Up Link
                                    _buildSignUpLink(),
                                    getVerticalSpacing(60),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Loading overlay
                      if (isLoading)
                        Container(
                          color: Colors.black.withValues(alpha: 0.5),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.email, style: AppStyles.inputLabel),
        getVerticalSpacing(5),
        CustomTextField(
          controller: _emailController,
          hint: AppStrings.enterYourEmail,
          icon: AppAssets.emailIcon,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          focusNode: _emailFocusNode,
          validator: Validators.email,
          semanticLabel: 'Email address input',
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.password, style: AppStyles.inputLabel),
        getVerticalSpacing(5),
        CustomTextField(
          controller: _passwordController,
          hint: AppStrings.enterYourPassword,
          icon: AppAssets.passwordIcon,
          obscureText: true,
          textInputAction: TextInputAction.done,
          focusNode: _passwordFocusNode,
          validator: Validators.password,
          semanticLabel: 'Password input',
          onFieldSubmitted: (_) => _handleLogin(context),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Align(
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
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.push(AppRoutes.forgotPassword),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: RichText(
              text: TextSpan(
                text: AppStrings.dontHaveAnAccount,
                style: AppStyles.signUpText,
                children: [
                  TextSpan(
                    text: ' ${AppStrings.signUp.toLowerCase()}',
                    style: AppStyles.signUpLink.copyWith(
                      color: AppColors.background,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = _navigateToSignUp,
                  ),
                ],
              ),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}
