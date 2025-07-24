import 'dart:math';
import 'package:flutter/material.dart';

class ResponsivityUtils {
  final BuildContext context;

  ResponsivityUtils(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;

  double get screenHeight => MediaQuery.of(context).size.height;

  double get shortestSide => MediaQuery.of(context).size.shortestSide;

  double responsiveSize(double percentage, double maxValue) {
    return min(shortestSide * percentage, maxValue);
  }

  EdgeInsets responsivePadding({
    double horizontalPercentage = 0.0,
    double verticalPercentage = 0.0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: shortestSide * horizontalPercentage,
      vertical: shortestSide * verticalPercentage,
    );
  }

  EdgeInsets responsiveMargin({
    double horizontalPercentage = 0.0,
    double verticalPercentage = 0.0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: shortestSide * horizontalPercentage,
      vertical: shortestSide * verticalPercentage,
    );
  }

  BorderRadius responsiveBorderRadius(double percentage) {
    return BorderRadius.circular(shortestSide * percentage);
  }
}
