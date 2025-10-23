import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/widgets/mcq_question_widget.dart';
import 'package:seed/core/widgets/screen_header.dart';

class McqsScreen extends StatefulWidget {
  const McqsScreen({super.key});

  @override
  State<McqsScreen> createState() => _McqsScreenState();
}

class _McqsScreenState extends State<McqsScreen> {
  final Map<int, String> selectedAnswers = {};
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<List<String>> questions = [
    ['A-ANS', 'B-ANS', 'D-ANS', 'C-ANS'],
    ['A-ANS', 'B-ANS', 'D-ANS', 'C-ANS'],
    ['A-ANS', 'B-ANS', 'D-ANS', 'C-ANS'],
    ['A-ANS', 'B-ANS', 'D-ANS', 'C-ANS'],
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onOptionSelected(int questionIndex, String option) {
    setState(() {
      selectedAnswers[questionIndex] = option;
    });
  }

  void _nextPage() {
    if (currentPage < questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  bool get _canProceed {
    if (currentPage == questions.length - 1) {
      // Last page - check if all questions are answered
      return selectedAnswers.length == questions.length;
    } else {
      // Not last page - check if current questions are answered
      int questionsPerPage = currentPage == 0 ? 2 : 2;
      int startIndex = currentPage == 0 ? 0 : 2;

      for (
        int i = startIndex;
        i < startIndex + questionsPerPage && i < questions.length;
        i++
      ) {
        if (!selectedAnswers.containsKey(i)) {
          return false;
        }
      }
      return true;
    }
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
              icon: AppAssets.initialAssessmentMcqIcon,
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
                    // MCQ Section Title
                    Text(
                      '~${AppStrings.mcq}',
                      style: AppStyles.mcqSectionTitle,
                    ),
                    getVerticalSpacing(20),
                    // Questions PageView
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        children: [
                          // Page 1: Questions 1-2
                          _buildQuestionsPage([0, 1]),
                          // Page 2: Questions 3-4
                          _buildQuestionsPage([2, 3]),
                        ],
                      ),
                    ),
                    // Action Button
                    Padding(
                      padding: EdgeInsets.all(24.w),
                      child: GestureDetector(
                        onTap: _canProceed
                            ? (currentPage == 1
                                  ? () {
                                      context.pop(true);
                                    }
                                  : _nextPage)
                            : null,
                        child: Container(
                          width: 78.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: _canProceed
                                ? AppColors.primary
                                : AppColors.primary.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              currentPage == 1
                                  ? AppStrings.done
                                  : AppStrings.next,
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

  Widget _buildQuestionsPage(List<int> questionIndices) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: questionIndices
              .map(
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: McqQuestionWidget(
                    questionNumber: index + 1,
                    options: questions[index],
                    selectedOption: selectedAnswers[index],
                    onOptionSelected: (option) =>
                        _onOptionSelected(index, option),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
