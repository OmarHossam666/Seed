import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/widgets/animated_press_button.dart';

class SkillCategoryButton extends StatelessWidget {
  const SkillCategoryButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPressButton(
      onTap: onTap,
      child: Container(
        width: 89.w,
        height: 94.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 39.w,
              height: 47.h,
              color: AppColors.background,
            ),
            Text(
              label,
              style: AppStyles.skillCategoryLabel,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
