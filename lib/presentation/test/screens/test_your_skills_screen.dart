import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/core/services/assessment_progress_service.dart';
import 'package:seed/presentation/test/widgets/skill_category_button.dart';

class TestYourSkillsScreen extends StatefulWidget {
  const TestYourSkillsScreen({super.key});

  @override
  State<TestYourSkillsScreen> createState() => _TestYourSkillsScreenState();
}

class _TestYourSkillsScreenState extends State<TestYourSkillsScreen> {
  int currentProgress = 0;
  final int totalProgress = 3;

  bool get isTestCompleted => currentProgress == totalProgress;

  void _loadProgress() async {
    final int progress =
        await AssessmentProgressService.getCompletedAssessmentsCount();
    setState(() {
      currentProgress = progress;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _navigateToMcq() async {
    final result = await context.push(AppRoutes.mcq);

    if (result == true) {
      AssessmentProgressService.setMcqCompleted();
      _loadProgress();
    }
  }

  void _navigateToEssay() async {
    final result = await context.push(AppRoutes.essay);

    if (result == true) {
      AssessmentProgressService.setEssayCompleted();
      _loadProgress();
    }
  }

  void _navigateToSoftSkills() async {
    final result = await context.push(AppRoutes.softSkills);

    if (result == true) {
      AssessmentProgressService.setSoftSkillsCompleted();
      _loadProgress();
    }
  }

  void _navigateToHome() {
    if (isTestCompleted) {
      context.pushReplacement(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Image.asset(
                  AppAssets.backButtonIcon,
                  width: 50.w,
                  height: 50.h,
                ),
              ),
            ),
            // Test Icon
            Image.asset(
              AppAssets.testIcon,
              width: 100.w,
              height: 100.h,
              color: AppColors.background,
            ),
            // Title
            Text(AppStrings.testYourSkills, style: AppStyles.testTitle),
            getVerticalSpacing(60),
            // Content Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(120.r),
                    topRight: Radius.circular(120.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        getVerticalSpacing(40),
                        // Skill Category Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SkillCategoryButton(
                              icon: AppAssets.essayIcon,
                              label: AppStrings.essay,
                              onTap: () {
                                _navigateToEssay();
                              },
                            ),
                            SkillCategoryButton(
                              icon: AppAssets.mcqIcon,
                              label: AppStrings.mcqs,
                              onTap: () {
                                _navigateToMcq();
                              },
                            ),
                            SkillCategoryButton(
                              icon: AppAssets.softSkillsIcon,
                              label: AppStrings.softSkills,
                              onTap: () {
                                _navigateToSoftSkills();
                              },
                            ),
                          ],
                        ),
                        getVerticalSpacing(40),
                        // Welcome Title
                        Text(
                          AppStrings.testYourSkillsTitle,
                          style: AppStyles.welcomeTitle,
                          textAlign: TextAlign.center,
                        ),
                        getVerticalSpacing(20),
                        // Description
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: AppStrings.testYourSkillsDescription,
                            style: AppStyles.descriptionText,
                            children: [
                              TextSpan(
                                text: AppStrings.takeYourTimeAndEnjoyTheJourney,
                                style: AppStyles.journeyText,
                              ),
                            ],
                          ),
                        ),
                        getVerticalSpacing(40),
                        // Progress Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppStrings.progress,
                                  style: AppStyles.progressLabel,
                                ),
                                Text(
                                  '$currentProgress/$totalProgress',
                                  style: AppStyles.progressValue,
                                ),
                              ],
                            ),
                            getVerticalSpacing(12),
                            // Progress Bar
                            Container(
                              width: double.infinity,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: AppColors.progressBackground,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(
                                  begin: 0.0,
                                  end: currentProgress / totalProgress,
                                ),
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.easeOutCubic,
                                builder: (context, value, child) {
                                  return FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        getVerticalSpacing(40),
                        // You're Ready Button
                        AnimatedScale(
                          scale: isTestCompleted ? 1.05 : 0.95,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutBack,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOutBack,
                            child: TextButton(
                              onPressed: () {
                                _navigateToHome();
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size(115.w, 35.h),
                                backgroundColor: isTestCompleted
                                    ? AppColors.primary
                                    : AppColors.readyButtonBackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                AppStrings.youAreReady,
                                style: AppStyles.readyButton,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
