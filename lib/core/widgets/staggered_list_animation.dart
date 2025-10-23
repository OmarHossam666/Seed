import 'package:flutter/material.dart';
import 'package:seed/core/animations/app_animations.dart';

/// Animates list items with staggered entrance
/// GPU-accelerated using transform and opacity
class StaggeredListAnimation extends StatelessWidget {
  const StaggeredListAnimation({
    super.key,
    required this.index,
    required this.child,
    this.delay = 50,
  });

  final int index;
  final Widget child;
  final int delay; // milliseconds between each item

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: AppAnimations.normal,
      curve: AppAnimations.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
