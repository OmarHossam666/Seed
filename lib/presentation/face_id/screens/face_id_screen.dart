import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/routes/app_routes.dart';

class FaceIdScreen extends StatefulWidget {
  const FaceIdScreen({super.key});

  @override
  State<FaceIdScreen> createState() => _FaceIdScreenState();
}

class _FaceIdScreenState extends State<FaceIdScreen> {
  void _navigateToSplash() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.pushReplacement(AppRoutes.splash);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _navigateToSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200.w,
              height: 200.h,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Layer 3 (Base layer) - Largest background
                  Container(
                    width: 128.w,
                    height: 129.h,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppAssets.layer3,
                      width: 128.w,
                      height: 129.h,
                    ),
                  ),
                  // Layer 2 - Medium layer
                  Container(
                    width: 104.w,
                    height: 104.h,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppAssets.layer2,
                      width: 104.w,
                      height: 104.h,
                    ),
                  ),
                  // Layer 1 - Smallest decorative layer
                  Container(
                    width: 72.w,
                    height: 76.h,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppAssets.layer1,
                      width: 72.w,
                      height: 76.h,
                    ),
                  ),
                  // Face ID icon - Centered on top of all layers
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(AppAssets.faceId),
                  ),
                ],
              ),
            ),
            getVerticalSpacing(27),
            Text(
              AppStrings.faceRecognition,
              style: AppStyles.faceIdTitle,
              textAlign: TextAlign.center,
            ),
            getVerticalSpacing(6),
            Text(
              AppStrings.faceRecognitionDescription,
              style: AppStyles.faceIdSubtitle,
              textAlign: TextAlign.center,
            ),
            getVerticalSpacing(39),
            Image.asset(AppAssets.checkMark),
          ],
        ),
      ),
    );
  }
}
