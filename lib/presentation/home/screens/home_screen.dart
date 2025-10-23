import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/presentation/home/widgets/custom_home_app_bar.dart';
import 'package:seed/presentation/home/widgets/leaderboard_card.dart';
import 'package:seed/presentation/home/widgets/recommending_cards_section.dart';
import 'package:seed/presentation/home/widgets/our_services_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerticalSpacing(20),
                const CustomHomeAppBar(),
                getVerticalSpacing(24),
                const LeaderboardCard(),
                getVerticalSpacing(32),
                const RecommendingCardsSection(),
                getVerticalSpacing(32),
                const OurServicesSection(),
                getVerticalSpacing(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
