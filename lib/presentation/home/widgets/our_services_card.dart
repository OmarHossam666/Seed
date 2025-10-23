import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_styles.dart';

class OurServicesCard extends StatelessWidget {
  const OurServicesCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.screenRoute,
  });

  final String title;
  final String imagePath;
  final String screenRoute;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(screenRoute),
      child: Container(
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(title, style: AppStyles.ourServicesCardTitle),
            ),
          ),
        ),
      ),
    );
  }
}
