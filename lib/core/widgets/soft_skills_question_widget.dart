import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/constants/app_styles.dart';
import 'package:seed/core/helpers/spacing.dart';

class SoftSkillsQuestionWidget extends StatefulWidget {
  const SoftSkillsQuestionWidget({
    super.key,
    required this.questionNumber,
    required this.onRecordingStateChanged,
  });

  final int questionNumber;
  final Function(bool isRecorded) onRecordingStateChanged;

  @override
  State<SoftSkillsQuestionWidget> createState() =>
      _SoftSkillsQuestionWidgetState();
}

class _SoftSkillsQuestionWidgetState extends State<SoftSkillsQuestionWidget>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;
  bool hasRecording = false;
  String recordingTime = "00:00";
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      if (isRecording) {
        // Stop recording
        isRecording = false;
        hasRecording = true;
        recordingTime = "00:15"; // Example duration
        widget.onRecordingStateChanged(true);
      } else {
        // Start recording
        isRecording = true;
        recordingTime = "00:00";
      }
    });
  }

  void _sendRecording() {
    if (hasRecording) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.textFieldBorder, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${widget.questionNumber}.Q', style: AppStyles.questionTitle),
          getVerticalSpacing(12),
          Container(
            height: 1.h,
            width: double.infinity,
            color: AppColors.primaryText,
          ),
          getVerticalSpacing(16),
          // Audio Recording Section
          Row(
            children: [
              // Microphone Button
              GestureDetector(
                onTap: _toggleRecording,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: isRecording ? Colors.red : AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: isRecording
                        ? [
                            BoxShadow(
                              color: Colors.red.withValues(alpha: 0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(
                    Icons.mic,
                    color: AppColors.background,
                    size: 20.sp,
                  ),
                ),
              ),
              getHorizontalSpacing(12),
              // Recording Time
              Text(
                recordingTime,
                style: AppStyles.answerOption.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Audio Waveform (Visual representation)
              Expanded(
                child: SizedBox(
                  height: 30.h,
                  child: AnimatedBuilder(
                    animation: _waveController,
                    builder: (context, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(20, (index) {
                          final baseHeight = isRecording
                              ? (10 + (index % 4) * 5).h
                              : hasRecording
                              ? (8 + (index % 3) * 4).h
                              : 8.h;

                          final animatedHeight = isRecording
                              ? baseHeight * (0.7 + 0.3 * _waveController.value)
                              : baseHeight;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 3.w,
                            height: animatedHeight,
                            margin: EdgeInsets.symmetric(horizontal: 1.w),
                            decoration: BoxDecoration(
                              color: isRecording
                                  ? Colors.red.withValues(alpha: 0.7)
                                  : hasRecording
                                  ? AppColors.primary.withValues(alpha: 0.7)
                                  : AppColors.primaryText.withValues(
                                      alpha: 0.3,
                                    ),
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
              // Send Button
              GestureDetector(
                onTap: hasRecording ? _sendRecording : null,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: hasRecording
                        ? AppColors.primary
                        : AppColors.primary.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    AppStrings.send,
                    style: AppStyles.doneButton.copyWith(fontSize: 12.sp),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
