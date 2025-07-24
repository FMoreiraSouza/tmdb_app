import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tmdb_app/core/constants/app_constants.dart';

class ResponsivityUtils {
  final BuildContext context;

  ResponsivityUtils(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;

  double get screenHeight => MediaQuery.of(context).size.height;

  double get shortestSide => MediaQuery.of(context).size.shortestSide;

  double get statusBarHeight => MediaQuery.of(context).padding.top;

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

  double searchBarHeight() {
    return responsiveSize(
          AppConstants.searchBarHeightPercentage,
          AppConstants.searchBarHeightBase,
        ) +
        responsivePadding(
          verticalPercentage: AppConstants.searchVerticalPaddingPercentage,
        ).vertical;
  }

  double availableContentHeight() {
    return screenHeight - kToolbarHeight - statusBarHeight - searchBarHeight();
  }

  double loadingTextSpacing() {
    return shortestSide * AppConstants.loadingTextSpacingPercentage;
  }

  double defaultSpacing({double multiplier = 1.0}) {
    return shortestSide * AppConstants.defaultSpacingPercentage * multiplier;
  }

  double smallSpacing() {
    return shortestSide * AppConstants.smallSpacingPercentage;
  }

  double dividerHeight() {
    return shortestSide * AppConstants.dividerHeightPercentage;
  }
}
