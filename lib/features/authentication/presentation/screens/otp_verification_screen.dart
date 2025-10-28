import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/features/authentication/presentation/widgets/forget_your_password_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    // Clear the controller before disposing to prevent issues with pin_code_fields
    _otpController.clear();
    _otpController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(22.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(),
              getVerticalSpacing(32),
              _buildHeader(),
              getVerticalSpacing(32),
              _buildOtpInput(),
              getVerticalSpacing(38),
              _buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () {
        if (mounted) {
          context.pop();
        }
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Image.asset(
          AppAssets.backButtonIcon,
          width: 24.w,
          height: 24.h,
          semanticLabel: 'Back button',
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.otpVerification, style: AppStyles.title),
        getVerticalSpacing(10),
        Text(AppStrings.otpSubtitle, style: AppStyles.homeSectionTitle),
      ],
    );
  }

  Widget _buildOtpInput() {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      controller: _otpController,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      textStyle: AppStyles.title,
      animationType: AnimationType.fade,
      animationDuration: const Duration(milliseconds: 200),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8.r),
        fieldWidth: 70.w,
        fieldHeight: 60.h,
        activeColor: AppColors.primary,
        activeFillColor: AppColors.textFieldBorder,
        selectedFillColor: AppColors.white,
        selectedColor: AppColors.primaryText,
        inactiveColor: AppColors.progressBackground,
        inactiveFillColor: AppColors.textFieldBorder,
        errorBorderColor: AppColors.error,
      ),
    );
  }

  Widget _buildVerifyButton() {
    return ForgetYourPasswordButton(
      text: AppStrings.verify,
      onPressed: () => context.pushReplacement(AppRoutes.createNewPassword),
    );
  }
}
