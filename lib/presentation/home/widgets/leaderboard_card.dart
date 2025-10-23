import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';

class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('#Your Rank', style: AppStyles.leaderboardTitle),
          getVerticalSpacing(16),
          ...List.generate(5, (index) => _buildRankItem(index + 1)),
        ],
      ),
    );
  }

  Widget _buildRankItem(int rank) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text('#$rank', style: AppStyles.leaderboardRank),
            ),
          ),
          SizedBox(width: 12.w),
          CircleAvatar(
            radius: 16.r,
            backgroundColor: AppColors.background.withValues(alpha: 0.3),
            child: Icon(Icons.person, color: AppColors.background, size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(child: Text('Name', style: AppStyles.leaderboardName)),
          Text('SCORE', style: AppStyles.leaderboardScore),
        ],
      ),
    );
  }
}
