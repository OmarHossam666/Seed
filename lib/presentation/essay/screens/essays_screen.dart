import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seed/core/constants/app_assets.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';
import 'package:seed/core/widgets/essay_question_widget.dart';
import 'package:seed/core/widgets/screen_header.dart';

class EssaysScreen extends StatefulWidget {
  const EssaysScreen({super.key});

  @override
  State<EssaysScreen> createState() => _EssaysScreenState();
}

class _EssaysScreenState extends State<EssaysScreen> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Add listeners to all text controllers to update UI when text changes
    for (var controller in _controllers) {
      controller.addListener(_updateButtonState);
    }
  }

  void _updateButtonState() {
    setState(() {
      // This will trigger a rebuild and recalculate _canProceed
    });
  }

  @override
  void dispose() {
    // Remove listeners before disposing
    for (var controller in _controllers) {
      controller.removeListener(_updateButtonState);
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (currentPage < 1) {
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
    if (currentPage == 1) {
      // Last page - check if questions 3-4 are answered
      return _controllers[2].text.trim().isNotEmpty &&
          _controllers[3].text.trim().isNotEmpty;
    } else {
      // First page - check if questions 1-2 are answered
      return _controllers[0].text.trim().isNotEmpty &&
          _controllers[1].text.trim().isNotEmpty;
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
              icon: AppAssets.initialAssessmentEssayIcon,
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
                    // Essays Section Title
                    Text(
                      '~${AppStrings.essays}',
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
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: EssayQuestionWidget(
                    questionNumber: index + 1,
                    controller: _controllers[index],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
