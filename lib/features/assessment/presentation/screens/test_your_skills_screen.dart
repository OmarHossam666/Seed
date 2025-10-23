import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/di/dependency_injection.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/core/utils/logger_service.dart';
import 'package:seed/features/assessment/domain/entities/assessment.dart';
import 'package:seed/features/assessment/presentation/bloc/assessment_bloc.dart';
import 'package:seed/features/assessment/presentation/bloc/assessment_event.dart';
import 'package:seed/features/assessment/presentation/bloc/assessment_state.dart';
import 'package:seed/features/assessment/presentation/widgets/skill_category_button.dart';

class TestYourSkillsScreen extends StatelessWidget {
  const TestYourSkillsScreen({super.key});

  Future<void> _navigateToAssessment(
    BuildContext context,
    String route,
    AssessmentType type,
  ) async {
    try {
      final result = await context.push(route);

      if (result == true && context.mounted) {
        LoggerService.debug('Assessment completed: ${type.name}');
        // Trigger assessment completion
        context.read<AssessmentBloc>().add(CompleteAssessment(type));
      }
    } catch (e, stackTrace) {
      LoggerService.error('Navigation error', e, stackTrace);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('An error occurred')));
      }
    }
  }

  void _navigateToHome(BuildContext context, bool isTestCompleted) {
    if (isTestCompleted && context.mounted) {
      context.pushReplacement(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AssessmentBloc>()..add(const LoadAssessmentProgress()),
      child: BlocConsumer<AssessmentBloc, AssessmentState>(
        listener: (context, state) {
          if (state is AssessmentError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          int currentProgress = 0;
          const int totalProgress = 3;
          bool isTestCompleted = false;

          if (state is AssessmentLoaded) {
            currentProgress = state.completedCount;
            isTestCompleted = state.allCompleted;
          }

          final isLoading = state is AssessmentLoading;

          return Scaffold(
            backgroundColor: AppColors.primary,
            body: SafeArea(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        // Header with back button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => context.pop(),
                            child: Semantics(
                              label: 'Go back',
                              button: true,
                              child: Image.asset(
                                AppAssets.backButtonIcon,
                                width: 50.w,
                                height: 50.h,
                              ),
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
                        Text(
                          AppStrings.testYourSkills,
                          style: AppStyles.testTitle,
                        ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SkillCategoryButton(
                                          icon: AppAssets.essayIcon,
                                          label: AppStrings.essay,
                                          onTap: () => _navigateToAssessment(
                                            context,
                                            AppRoutes.essay,
                                            AssessmentType.essay,
                                          ),
                                        ),
                                        SkillCategoryButton(
                                          icon: AppAssets.mcqIcon,
                                          label: AppStrings.mcqs,
                                          onTap: () => _navigateToAssessment(
                                            context,
                                            AppRoutes.mcq,
                                            AssessmentType.mcq,
                                          ),
                                        ),
                                        SkillCategoryButton(
                                          icon: AppAssets.softSkillsIcon,
                                          label: AppStrings.softSkills,
                                          onTap: () => _navigateToAssessment(
                                            context,
                                            AppRoutes.softSkills,
                                            AssessmentType.softSkills,
                                          ),
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
                                        text: AppStrings
                                            .testYourSkillsDescription,
                                        style: AppStyles.descriptionText,
                                        children: [
                                          TextSpan(
                                            text: AppStrings
                                                .takeYourTimeAndEnjoyTheJourney,
                                            style: AppStyles.journeyText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    getVerticalSpacing(40),
                                    // Progress Section
                                    _buildProgressSection(
                                      currentProgress,
                                      totalProgress,
                                    ),
                                    getVerticalSpacing(40),
                                    // You're Ready Button
                                    _buildReadyButton(context, isTestCompleted),
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
        },
      ),
    );
  }

  Widget _buildProgressSection(int currentProgress, int totalProgress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.progress, style: AppStyles.progressLabel),
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
            tween: Tween(begin: 0.0, end: currentProgress / totalProgress),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReadyButton(BuildContext context, bool isTestCompleted) {
    return AnimatedScale(
      scale: isTestCompleted ? 1.05 : 0.95,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutBack,
        child: TextButton(
          onPressed: () => _navigateToHome(context, isTestCompleted),
          style: TextButton.styleFrom(
            minimumSize: Size(115.w, 35.h),
            backgroundColor: isTestCompleted
                ? AppColors.primary
                : AppColors.readyButtonBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(AppStrings.youAreReady, style: AppStyles.readyButton),
        ),
      ),
    );
  }
}
