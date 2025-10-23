import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_fonts.dart';

class AppStyles {
  AppStyles._();

  static final TextStyle title = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 28.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.05.sp,
    color: AppColors.background,
  );

  static final TextStyle faceIdTitle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle faceIdSubtitle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  // Login Screen Styles
  static final TextStyle loginTitle = TextStyle(
    color: AppColors.primary,
    fontFamily: AppFonts.inter,
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.sp,
  );

  static final TextStyle inputLabel = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle inputText = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle forgotPassword = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
  );

  static final TextStyle signUpText = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle signUpLink = TextStyle(
    color: AppColors.primary,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  // Sign Up Screen Styles
  static final TextStyle nextButton = TextStyle(
    color: AppColors.background,
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle dropdownText = TextStyle(
    color: AppColors.primaryText.withValues(alpha: 0.6),
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  // Test Your Skills Screen Styles
  static final TextStyle testTitle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle skillCategoryLabel = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle welcomeTitle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle descriptionText = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle journeyText = TextStyle(
    color: AppColors.primary,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle progressLabel = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle progressValue = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle readyButton = TextStyle(
    color: AppColors.background,
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  // MCQ Screen Styles
  static final TextStyle assessmentTitle = TextStyle(
    color: AppColors.background,
    fontFamily: AppFonts.inter,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle mcqSectionTitle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle questionTitle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle answerOption = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle doneButton = TextStyle(
    color: AppColors.background,
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  // Home Screen Styles
  static final TextStyle homeGreeting = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle homeFollowersCount = TextStyle(
    color: AppColors.primary,
    fontFamily: AppFonts.inter,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle homeSectionTitle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  // Leaderboard Card Styles
  static final TextStyle leaderboardTitle = TextStyle(
    color: AppColors.background,
    fontFamily: AppFonts.inter,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle leaderboardRank = TextStyle(
    color: AppColors.background,
    fontFamily: AppFonts.inter,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle leaderboardName = TextStyle(
    color: AppColors.background,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle leaderboardScore = TextStyle(
    color: AppColors.background,
    fontFamily: AppFonts.inter,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  // Recommending Card Styles
  static final TextStyle recommendingCardTitle = TextStyle(
    color: AppColors.background,
    fontFamily: AppFonts.inter,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle recommendingCardCompany = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle recommendingCardSalary = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle recommendingCardDescription = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // Our Services Card Styles
  static final TextStyle ourServicesCardTitle = TextStyle(
    color: AppColors.background,
    fontFamily: AppFonts.inter,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  // Job Dialog Styles
  static final TextStyle jobDialogCompanyName = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle jobDialogSalary = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle jobDialogDescription = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static final TextStyle jobDialogRequirementsTitle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle jobDialogRequirement = TextStyle(
    color: AppColors.primaryText,
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
}
