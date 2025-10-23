import 'package:flutter/material.dart';

/// Centralized animation configuration for consistent timing and easing
class AppAnimations {
  AppAnimations._();

  // Duration constants - Made more noticeable
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 700);
  static const Duration splash = Duration(milliseconds: 1200);

  // Easing curves
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve spring = Curves.elasticOut;
  static const Curve bounce = Curves.bounceOut;
  static const Curve dramatic = Curves.easeOutBack;

  // Scale values for press feedback - More dramatic
  static const double pressedScale = 0.92;
  static const double hoveredScale = 1.05;
}
