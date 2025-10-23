import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';

class ProfileSheet extends StatelessWidget {
  const ProfileSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.80,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.gradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(120.r),
            bottomRight: Radius.circular(120.r),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileInfo(),
                    getVerticalSpacing(24),
                    _buildAboutSection(),
                    getVerticalSpacing(24),
                    _buildSkillsSection(),
                    getVerticalSpacing(24),
                    _buildActionButtons(),
                    getVerticalSpacing(24),
                    _buildMediaSection(),
                    getVerticalSpacing(24),
                    _buildContactSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.background,
            child: Icon(Icons.person, color: AppColors.primary, size: 24.sp),
          ),
          getHorizontalSpacing(12),
          Text(
            'Nour',
            style: AppStyles.title.copyWith(
              fontSize: 20.sp,
              decoration: TextDecoration.none,
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Icon(Icons.star, color: AppColors.background, size: 16.sp),
                getHorizontalSpacing(4),
                Text(
                  AppStrings.rank,
                  style: AppStyles.title.copyWith(
                    fontSize: 14.sp,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Row(
      children: [
        Text(
          AppStrings.backendDeveloper,
          style: AppStyles.title.copyWith(
            fontSize: 16.sp,
            decoration: TextDecoration.none,
          ),
        ),
        getHorizontalSpacing(8),
        Icon(Icons.edit, color: AppColors.background, size: 16.sp),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppStrings.about,
              style: AppStyles.title.copyWith(
                fontSize: 18.sp,
                decoration: TextDecoration.none,
              ),
            ),
            getHorizontalSpacing(8),
            Icon(Icons.edit, color: AppColors.background, size: 16.sp),
          ],
        ),
        getVerticalSpacing(12),
        Text(
          AppStrings.aboutDescription,
          style: AppStyles.title.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.4,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.skills,
          style: AppStyles.title.copyWith(
            fontSize: 18.sp,
            decoration: TextDecoration.none,
          ),
        ),
        getVerticalSpacing(12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.backend,
                style: AppStyles.title.copyWith(
                  fontSize: 14.sp,
                  decoration: TextDecoration.none,
                ),
              ),
              getHorizontalSpacing(8),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: AppColors.primary, size: 12.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildActionButton(AppStrings.portfolio, Icons.work_outline),
        getHorizontalSpacing(16),
        _buildActionButton(AppStrings.links, Icons.link),
      ],
    );
  }

  Widget _buildActionButton(String title, IconData icon) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyles.title.copyWith(
            fontSize: 16.sp,
            decoration: TextDecoration.none,
          ),
        ),
        getHorizontalSpacing(8),
        Icon(icon, color: AppColors.background, size: 16.sp),
      ],
    );
  }

  Widget _buildMediaSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(Icons.share, color: AppColors.primary, size: 32.sp),
          getVerticalSpacing(8),
          Text(
            AppStrings.media,
            style: AppStyles.homeSectionTitle.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.phone, color: Colors.white, size: 30.sp),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.email, color: Colors.white, size: 30.sp),
        ),
      ],
    );
  }
}
