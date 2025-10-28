import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/presentation/home/widgets/profile_sheet.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: '',
                  barrierColor: Colors.black.withValues(alpha: 0.5),
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const ProfileSheet();
                  },
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, -1),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                ),
                              ),
                          child: child,
                        );
                      },
                );
              },
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.person,
                  color: AppColors.background,
                  size: 24.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Text(AppStrings.helloNour, style: AppStyles.homeGreeting),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.people, color: AppColors.primary, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(AppStrings.rank, style: AppStyles.homeFollowersCount),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            IconButton(
              onPressed: () => showNotificationsDialog(context),
              icon: Icon(
                Icons.notifications_outlined,
                color: AppColors.primary,
                size: 24.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showNotificationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsetsGeometry.all(32.r),
          constraints: BoxConstraints(maxWidth: 285.w, maxHeight: 350.h),
          backgroundColor: AppColors.background,
          content: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: Image.asset(
                    AppAssets.cancelIcon,
                    width: 24.w,
                    height: 47.h,
                    semanticLabel: 'Close notifications dialog',
                  ),
                ),
              ),
              getVerticalSpacing(8),
              Image.asset(
                AppAssets.noMessagesIcon,
                width: 100.w,
                height: 100.h,
                semanticLabel: 'No notifications illustration',
              ),
              getVerticalSpacing(30),
              Text(
                AppStrings.noMessagesYet,
                style: AppStyles.homeSectionTitle.copyWith(
                  color: const Color(0xFF093EA0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
