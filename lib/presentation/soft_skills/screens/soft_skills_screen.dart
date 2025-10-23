import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/widgets/screen_header.dart';
import 'package:seed/core/widgets/soft_skills_question_widget.dart';

class SoftSkillsScreen extends StatefulWidget {
  const SoftSkillsScreen({super.key});

  @override
  State<SoftSkillsScreen> createState() => _SoftSkillsScreenState();
}

class _SoftSkillsScreenState extends State<SoftSkillsScreen> {
  final Map<int, bool> recordingStates = {};

  void _onRecordingStateChanged(int questionIndex, bool isRecorded) {
    setState(() {
      recordingStates[questionIndex] = isRecorded;
    });
  }

  bool get _allQuestionsAnswered {
    return recordingStates.length == 4 &&
        recordingStates.values.every((recorded) => recorded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(
              title: AppStrings.initialAssessment,
              titleStyle: AppStyles.assessmentTitle,
              icon: AppAssets.initialAssessmentSoftSkillsIcon,
            ),
            // Content Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.r),
                  ),
                ),
                child: Column(
                  children: [
                    getVerticalSpacing(20),
                    // Soft Skills Section Title
                    Text(
                      '~${AppStrings.softSkills}',
                      style: AppStyles.mcqSectionTitle,
                    ),
                    getVerticalSpacing(20),
                    // Questions List
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: List.generate(
                              4,
                              (index) => Padding(
                                padding: EdgeInsets.only(bottom: 24.h),
                                child: SoftSkillsQuestionWidget(
                                  questionNumber: index + 1,
                                  onRecordingStateChanged: (isRecorded) =>
                                      _onRecordingStateChanged(
                                        index,
                                        isRecorded,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Done Button
                    Padding(
                      padding: EdgeInsets.all(24.w),
                      child: GestureDetector(
                        onTap: _allQuestionsAnswered
                            ? () {
                                context.pop(true);
                              }
                            : null,
                        child: Container(
                          width: 78.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: _allQuestionsAnswered
                                ? AppColors.primary
                                : AppColors.primary.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              AppStrings.done,
                              style: AppStyles.doneButton,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
