import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/widgets/custom_search_bar.dart';

class ScreenHeader extends StatefulWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    this.backgroundImage,
    this.titleStyle,
    this.icon,
    this.showBackButton = true,
    this.showStatusBar = true,
    this.showSearchBar = false,
    this.onSearch,
  });

  final String title;
  final String? backgroundImage;
  final TextStyle? titleStyle;
  final String? icon;
  final bool showBackButton;
  final bool showStatusBar;
  final bool showSearchBar;
  final void Function(String)? onSearch;

  @override
  State<ScreenHeader> createState() => _ScreenHeaderState();
}

class _ScreenHeaderState extends State<ScreenHeader> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Assessment screen style (with icon, no background image)
    if (widget.icon != null && widget.backgroundImage == null) {
      return _buildAssessmentHeader(context);
    }

    // Learning screen style (with background image)
    return _buildLearningHeader(context);
  }

  Widget _buildAssessmentHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          // Back button
          if (widget.showBackButton)
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Image.asset(
                    AppAssets.backButtonIcon,
                    width: 50.w,
                    height: 50.h,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(child: CustomSearchBar(controller: _searchController)),
              ],
            ),
          // Icon
          if (widget.icon != null) ...[
            SizedBox(height: 20.h),
            Image.asset(
              widget.icon!,
              width: 100.w,
              height: 100.h,
              color: AppColors.background,
            ),
          ],
          // Title
          SizedBox(height: 16.h),
          Text(
            widget.title,
            style: widget.titleStyle ?? AppStyles.assessmentTitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLearningHeader(BuildContext context) {
    return Container(
      width: 360.w,
      height: 254.h,
      decoration: BoxDecoration(
        image: widget.backgroundImage != null
            ? DecorationImage(
                image: AssetImage(widget.backgroundImage!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.3),
              Colors.black.withValues(alpha: 0.6),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.showStatusBar) _buildStatusBar(context),
              const Spacer(),
              Text(widget.title, style: widget.titleStyle ?? AppStyles.title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.showBackButton)
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Image.asset(
                  AppAssets.backButtonIcon,
                  width: 30.w,
                  height: 30.h,
                  color: Colors.white,
                ),
              ),
            if (widget.showSearchBar) ...[
              const Spacer(),
              CustomSearchBar(
                controller: _searchController,
                onChanged: widget.onSearch,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
