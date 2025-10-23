import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/presentation/home/widgets/home_section_title.dart';
import 'package:seed/presentation/home/widgets/our_services_card.dart';

class OurServicesSection extends StatelessWidget {
  const OurServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OurServicesCard> ourServicesCards = [
      OurServicesCard(
        title: 'Jobs',
        imagePath: AppAssets.jobsImage,
        screenRoute: AppRoutes.jobs,
      ),
      OurServicesCard(
        title: 'Learning',
        imagePath: AppAssets.learningImage,
        screenRoute: AppRoutes.learning,
      ),
      OurServicesCard(
        title: 'Weekly Test',
        imagePath: AppAssets.weeklyTestImage,
        screenRoute: AppRoutes.weeklyTest,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionTitle(title: AppStrings.our, subtitle: AppStrings.services),
        getVerticalSpacing(16),
        Column(spacing: 16.h, children: ourServicesCards),
      ],
    );
  }
}
