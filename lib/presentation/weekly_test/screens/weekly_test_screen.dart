import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/core/widgets/screen_header.dart';
import 'package:seed/presentation/home/widgets/custom_home_app_bar.dart';

class WeeklyTestScreen extends StatelessWidget {
  const WeeklyTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: const CustomHomeAppBar(),
            ),
            ScreenHeader(
              backgroundImage: AppAssets.weeklyTestImage,
              title: AppStrings.weeklyTest,
              showBackButton: true,
              showStatusBar: true,
              showSearchBar: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    getVerticalSpacing(24),
                    _buildPointsSection(),
                    getVerticalSpacing(24),
                    _buildTestCard(),
                    getVerticalSpacing(24),
                    _buildStartButton(context),
                    getVerticalSpacing(24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.person,
                  color: AppColors.background,
                  size: 25.sp,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 16.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 2),
                  ),
                  child: Icon(
                    Icons.check,
                    color: AppColors.background,
                    size: 8.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        getHorizontalSpacing(8),
        Text(
          '243',
          style: AppStyles.homeSectionTitle.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildTestCard() {
    return Container(
      width: double.infinity,
      height: 506.h,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Test icon
          Image.asset(AppAssets.testIcon, width: 100.w, height: 100.h),
          getVerticalSpacing(17),
          // Title
          Text(
            AppStrings.testYourSkills,
            style: AppStyles.assessmentTitle.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          getVerticalSpacing(68),
          // Skills icons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSkillIcon(AppAssets.essayIcon, AppStrings.essay),
              _buildSkillIcon(AppAssets.mcqIcon, AppStrings.mcqs),
              _buildSkillIcon(AppAssets.mcqIcon, AppStrings.softSkills),
            ],
          ),
          getVerticalSpacing(74),
          // Points text
          Text(
            '+ Points',
            style: AppStyles.assessmentTitle.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillIcon(String iconPath, String label) {
    return Column(
      children: [
        Image.asset(iconPath, width: 50.w, height: 50.h),
        getVerticalSpacing(8),
        Text(
          label,
          style: AppStyles.assessmentTitle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Container(
        width: 120.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextButton(
          onPressed: () {
            context.push(AppRoutes.test);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text('Start', style: AppStyles.nextButton),
        ),
      ),
    );
  }
}
