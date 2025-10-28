import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/presentation/home/widgets/custom_home_app_bar.dart';
import 'package:seed/core/widgets/screen_header.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

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
              backgroundImage: AppAssets.learningImage,
              title: AppStrings.learning,
              showBackButton: true,
              showStatusBar: true,
              showSearchBar: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getVerticalSpacing(24),
                    _buildHeaderSection('Recommended', 'playlists for you'),
                    getVerticalSpacing(24),
                    _buildVideoPlaylist(),
                    getVerticalSpacing(24),
                    _buildHeaderSection('Your', 'History'),
                    getVerticalSpacing(24),
                    _buildVideoPlaylist(isRecommended: false),
                    getVerticalSpacing(24),
                    TextButton(
                      onPressed: () {},
                      child: Text('View More', style: AppStyles.welcomeTitle),
                    ),
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

  Widget _buildHeaderSection(String title, String subtitle) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppStyles.homeSectionTitle),
            Text(
              subtitle,
              style: AppStyles.homeSectionTitle.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.refresh, color: Colors.grey, size: 35.sp),
        ),
      ],
    );
  }

  Widget _buildVideoPlaylist({bool isRecommended = true}) {
    final playlists = _getPlaylistData();
    return Column(
      children: playlists
          .map(
            (playlist) =>
                _buildVideoCard(playlist, isRecommended: isRecommended),
          )
          .toList(),
    );
  }

  Widget _buildVideoCard(
    Map<String, String> playlist, {
    bool isRecommended = true,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
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
        children: [
          // Video thumbnail container
          Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              image: const DecorationImage(
                image: AssetImage(AppAssets.learningScreenVideoImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.6),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppColors.background,
                    size: 30.sp,
                  ),
                ),
              ),
            ),
          ),
          // Title container
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isRecommended ? null : Colors.grey,
              gradient: isRecommended
                  ? LinearGradient(
                      colors: AppColors.gradient,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.r),
              ),
            ),
            child: Text(
              playlist['title']!,
              style: AppStyles.recommendingCardTitle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getPlaylistData() {
    return [
      {'title': 'SQL - Back-End'},
      {'title': 'Front-End'},
      {'title': 'Full Stack'},
    ];
  }
}
