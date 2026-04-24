import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void success(BuildContext context, String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.success,
      mobilePositionSettings: MobilePositionSettings(
      ),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void error(BuildContext context, String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.error,
      mobilePositionSettings: const MobilePositionSettings(
      ),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void warning(BuildContext context, String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.warning,
      mobilePositionSettings: const MobilePositionSettings(
      ),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void info(BuildContext context, String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.info,
      mobilePositionSettings: const MobilePositionSettings(
      ),
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
