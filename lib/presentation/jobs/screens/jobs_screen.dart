import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/widgets/screen_header.dart';
import 'package:seed/presentation/home/widgets/custom_home_app_bar.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.r),
              child: const CustomHomeAppBar(),
            ),
            ScreenHeader(
              backgroundImage: AppAssets.jobsImage,
              title: AppStrings.jobTitle,
              showSearchBar: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    getVerticalSpacing(20),
                    _buildCreateButton(),
                    getVerticalSpacing(24),
                    ..._buildJobCards(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return Container(
      width: 104.w,
      height: 38.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        child: Text('Create', style: AppStyles.nextButton),
      ),
    );
  }

  List<Widget> _buildJobCards() {
    final jobs = _getJobsData();
    return jobs.map((job) => _buildJobCard(job)).toList();
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.primary,
                child: Icon(
                  job['icon'] as IconData,
                  color: AppColors.background,
                  size: 20.sp,
                ),
              ),
              getHorizontalSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job['company'] as String,
                      style: AppStyles.jobDialogCompanyName,
                    ),
                    Text(
                      job['duration'] as String,
                      style: TextStyle(
                        color: AppColors.primaryText.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Text(job['salary'] as String, style: AppStyles.jobDialogSalary),
            ],
          ),
          getVerticalSpacing(12),
          Text(AppStrings.about, style: AppStyles.jobDialogRequirementsTitle),
          getVerticalSpacing(8),
          Text(
            job['description'] as String,
            style: AppStyles.jobDialogDescription,
          ),
          getVerticalSpacing(12),
          Text(
            AppStrings.requirements,
            style: AppStyles.jobDialogRequirementsTitle,
          ),
          getVerticalSpacing(8),
          ...(job['requirements'] as List<String>).map(
            (requirement) => Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4.w,
                    height: 4.h,
                    margin: EdgeInsets.only(top: 8.h, right: 8.w),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryText,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      requirement,
                      style: AppStyles.jobDialogRequirement,
                    ),
                  ),
                ],
              ),
            ),
          ),
          getVerticalSpacing(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.phone, color: AppColors.primary, size: 24.sp),
              ),
              getHorizontalSpacing(16),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.email, color: AppColors.primary, size: 24.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getJobsData() {
    return [
      {
        'company': 'company',
        'duration': '3-6 months',
        'salary': '\$1,500',
        'icon': Icons.business,
        'description':
            'We are a growing startup building a fitness & wellness mobile app inspired by personalized workout plans and nutrition guidance. Our app is built on a React Native app, and we need a skilled backend engineer to design and implement the server-side infrastructure.',
        'requirements': [
          'Strong experience with Node.js (Express/NestJS) or Python (Django/FastAPI)',
          'Proficiency with PostgreSQL and writing optimized SQL queries',
          'Experience with Redis for caching',
          'Experience with JWT authentication and API security best practices',
          'Familiarity with Docker and cloud platforms (AWS/GCP)',
          'Good communication skills and ability to work in a distributed team',
        ],
      },
      {
        'company': '--',
        'duration': '--',
        'salary': '\$0.00',
        'icon': Icons.work_outline,
        'description': '...',
        'requirements': ['...', '...', '...', '...', '...'],
      },
    ];
  }
}
