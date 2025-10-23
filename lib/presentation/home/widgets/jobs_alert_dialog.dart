import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/presentation/home/widgets/recommending_card.dart';

class JobsAlertDialog extends StatelessWidget {
  const JobsAlertDialog({super.key, required this.recommendingCard});

  final RecommendingCard recommendingCard;

  bool get isJob => recommendingCard.title == AppStrings.jobTitle;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 320.w,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Header
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    recommendingCard.icon,
                    color: AppColors.background,
                    size: 24.sp,
                  ),
                ),
                getHorizontalSpacing(12),
                Text(
                  recommendingCard.company,
                  style: AppStyles.jobDialogCompanyName,
                ),
              ],
            ),
            getVerticalSpacing(16),

            // Duration and Salary
            Center(
              child: Text(
                recommendingCard.salary,
                style: AppStyles.jobDialogSalary,
              ),
            ),
            getVerticalSpacing(20),

            // Job Description
            Text(
              recommendingCard.description,
              style: AppStyles.jobDialogDescription,
            ),
            getVerticalSpacing(20),

            // Requirements / What you will learn Section
            Text(
              isJob ? AppStrings.requirements : AppStrings.whatYouWillLearn,
              style: AppStyles.jobDialogRequirementsTitle,
            ),
            getVerticalSpacing(12),

            // Requirements List
            ...recommendingCard.requirements.map(
              (requirement) => _buildRequirement(requirement),
            ),
            if (isJob)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.phone,
                      color: AppColors.primary,
                      size: 30.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.email,
                      color: AppColors.primary,
                      size: 30.sp,
                    ),
                  ),
                ],
              ),
            if (!isJob)
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.link,
                    style: AppStyles.homeSectionTitle.copyWith(
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirement(String requirement) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4.w,
            height: 4.h,
            margin: EdgeInsets.only(top: 8.h, right: 8.w),
            decoration: BoxDecoration(
              color: AppColors.primaryText,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(requirement, style: AppStyles.jobDialogRequirement),
          ),
        ],
      ),
    );
  }
}
