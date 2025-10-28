import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_colors.dart';
import 'package:seed/core/constants/app_styles.dart';

/// Custom search bar widget with app styling
class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText = 'Search',
    this.enabled = true,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onClear,
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String hintText;
  final bool enabled;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onClear;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _showClearButton) {
      setState(() {
        _showClearButton = hasText;
        if (hasText) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      });
    }
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleClear() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.w,
      height: 40.h,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        style: AppStyles.inputText.copyWith(
          color: AppColors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: AppColors.white,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.primary,
          hintText: widget.hintText,
          hintStyle: AppStyles.inputText.copyWith(
            color: AppColors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon:
              widget.prefixIcon ??
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Icon(
                  Icons.search_rounded,
                  color: AppColors.black,
                  size: 28.sp,
                ),
              ),
          suffixIcon: _showClearButton
              ? ScaleTransition(
                  scale: _scaleAnimation,
                  child:
                      widget.suffixIcon ??
                      IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: AppColors.black,
                          size: 24.sp,
                        ),
                        onPressed: _handleClear,
                        tooltip: 'Clear search',
                        padding: EdgeInsets.all(8.r),
                      ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.r),
            borderSide: BorderSide(width: 1.w, color: AppColors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.r),
            borderSide: BorderSide(width: 1.w, color: AppColors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.r),
            borderSide: BorderSide(
              color: AppColors.primary.withValues(alpha: 0.5),
              width: 2.w,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 60.w),
        ),
      ),
    );
  }
}
