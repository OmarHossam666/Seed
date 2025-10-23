import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_styles.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    this.backgroundImage,
    this.titleStyle,
    this.icon,
    this.showBackButton = true,
    this.showStatusBar = true,
  });

  final String title;
  final String? backgroundImage;
  final TextStyle? titleStyle;
  final String? icon;
  final bool showBackButton;
  final bool showStatusBar;

  @override
  Widget build(BuildContext context) {
    // Assessment screen style (with icon, no background image)
    if (icon != null && backgroundImage == null) {
      return _buildAssessmentHeader(context);
    }

    // Learning screen style (with background image)
    return _buildLearningHeader(context);
  }

  Widget _buildAssessmentHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          // Back button
          if (showBackButton)
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Image.asset(
                  AppAssets.backButtonIcon,
                  width: 50.w,
                  height: 50.h,
                ),
              ),
            ),
          // Icon
          if (icon != null) ...[
            SizedBox(height: 20.h),
            Image.asset(
              icon!,
              width: 100.w,
              height: 100.h,
              color: AppColors.background,
            ),
          ],
          // Title
          SizedBox(height: 16.h),
          Text(
            title,
            style: titleStyle ?? AppStyles.assessmentTitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLearningHeader(BuildContext context) {
    return Container(
      width: 360.w,
      height: 254.h,
      decoration: BoxDecoration(
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.3),
              Colors.black.withValues(alpha: 0.6),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showStatusBar) _buildStatusBar(context),
              const Spacer(),
              Text(title, style: titleStyle ?? AppStyles.title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    return Row(
      children: [
        if (showBackButton)
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(
              AppAssets.backButtonIcon,
              width: 30.w,
              height: 30.h,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
