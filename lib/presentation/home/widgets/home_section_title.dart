import 'package:flutter/material.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_styles.dart';

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: AppStyles.homeSectionTitle,
        children: [
          TextSpan(
            text: subtitle,
            style: AppStyles.homeSectionTitle.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}