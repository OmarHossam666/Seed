import 'package:flutter/material.dart';
import 'package:seed/core/animations/app_animations.dart';

/// Custom page route with slide + fade transition
/// GPU-accelerated using transform and opacity
class AnimatedPageTransition extends PageRouteBuilder {
  final Widget page;

  AnimatedPageTransition({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: AppAnimations.normal,
        reverseTransitionDuration: AppAnimations.normal,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Slide from right with fade
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final slideTween = Tween(begin: begin, end: end);
          final slideAnimation = animation.drive(
            slideTween.chain(CurveTween(curve: AppAnimations.easeInOut)),
          );

          final fadeTween = Tween<double>(begin: 0.0, end: 1.0);
          final fadeAnimation = animation.drive(
            fadeTween.chain(CurveTween(curve: AppAnimations.easeOut)),
          );

          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(opacity: fadeAnimation, child: child),
          );
        },
      );
}
