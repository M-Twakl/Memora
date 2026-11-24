import 'package:flutter/material.dart';

/// Centralized border radius constants.
abstract class AppRadius {
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 24.0;
  static const double circular = 999.0;

  static const BorderRadius roundedS = BorderRadius.all(Radius.circular(s));
  static const BorderRadius roundedM = BorderRadius.all(Radius.circular(m));
  static const BorderRadius roundedL = BorderRadius.all(Radius.circular(l));
  static const BorderRadius roundedXL = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius roundedCircular = BorderRadius.all(Radius.circular(circular));
}
