import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/widgets/animated_press_button.dart';
import 'package:seed/presentation/home/widgets/jobs_alert_dialog.dart';

class RecommendingCard extends StatelessWidget {
  const RecommendingCard({
    super.key,
    required this.title,
    required this.company,
    required this.salary,
    required this.description,
    required this.icon,
    required this.requirements,
  });

  final String title;
  final String company;
  final String salary;
  final String description;
  final IconData icon;
  final List<String> requirements;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedPressButton(
        scaleValue: 0.97,
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => JobsAlertDialog(recommendingCard: this),
          );
        },
        child: Container(
          width: 273.w,
          height: 342.h,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.gradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: AppStyles.recommendingCardTitle),
              getVerticalSpacing(16),
              Expanded(
                child: Center(
                  child: Container(
                    width: 195.w,
                    height: 238.h,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12.r,
                              backgroundColor: AppColors.primary.withValues(
                                alpha: 0.1,
                              ),
                              child: Icon(
                                icon,
                                color: AppColors.primary,
                                size: 12.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              company,
                              style: AppStyles.recommendingCardCompany,
                            ),
                          ],
                        ),
                        getVerticalSpacing(8),
                        Text(salary, style: AppStyles.recommendingCardSalary),
                        getVerticalSpacing(12),
                        Text(
                          description,
                          style: AppStyles.recommendingCardDescription,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
