import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';

class EssayQuestionWidget extends StatelessWidget {
  const EssayQuestionWidget({
    super.key,
    required this.questionNumber,
    required this.controller,
  });

  final int questionNumber;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.textFieldBorder, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$questionNumber. ${AppStrings.question}',
            style: AppStyles.questionTitle,
          ),
          getVerticalSpacing(12),
          Container(
            height: 1.h,
            width: double.infinity,
            color: AppColors.primaryText,
          ),
          getVerticalSpacing(16),
          TextField(
            controller: controller,
            maxLines: 6,
            style: AppStyles.answerOption,
            decoration: InputDecoration(
              hintText: AppStrings.ans,
              hintStyle: AppStyles.answerOption.copyWith(
                color: AppColors.primaryText.withValues(alpha: 0.4),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
