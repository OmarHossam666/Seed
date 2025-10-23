import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';

class McqQuestionWidget extends StatelessWidget {
  const McqQuestionWidget({
    super.key,
    required this.questionNumber,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  final int questionNumber;
  final List<String> options;
  final String? selectedOption;
  final Function(String) onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$questionNumber. MCQ', style: AppStyles.questionTitle),
        getVerticalSpacing(16),
        ...options
            .map(
              (option) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: GestureDetector(
                  onTap: () => onOptionSelected(option),
                  child: Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedOption == option
                                ? AppColors.primary
                                : AppColors.primaryText.withValues(alpha: 0.3),
                            width: 2.w,
                          ),
                          color: selectedOption == option
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                        child: selectedOption == option
                            ? Center(
                                child: Container(
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.background,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      getHorizontalSpacing(12),
                      Text(option, style: AppStyles.answerOption),
                    ],
                  ),
                ),
              ),
            )
            ,
      ],
    );
  }
}
