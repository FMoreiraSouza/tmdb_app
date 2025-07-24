import 'package:flutter/material.dart';

class AppConstants {
  static const double iconSizePercentage = 0.1;
  static const double iconSizeBase = 50.0;
  static const double smallIconSizePercentage = 0.08;
  static const double smallIconSizeBase = 30.0;
  static const double tinyIconSizePercentage = 0.03;
  static const double tinyIconSizeBase = 12.0;
  static const double imageSizePercentage = 0.12;
  static const double imageSizeBase = 60.0;
  static const double searchIconSizePercentage = 0.06;
  static const double searchIconSizeBase = 24.0;
  static const double textSizePercentage = 0.04;
  static const double textSizeBase = 16.0;
  static const double smallTextSizePercentage = 0.035;
  static const double smallTextSizeBase = 14.0;
  static const double switchButtonWidthPercentage = 0.12;
  static const double switchButtonWidthBase = 60.0;
  static const double switchButtonHeightPercentage = 0.1;
  static const double switchButtonHeightBase = 50.0;
  static const double switchButtonImageSizePercentage = 0.05;
  static const double switchButtonImageSizeBase = 24.0;
  static const double ratingContainerSizePercentage = 0.1;
  static const double ratingContainerSizeBase = 40.0;

  static const double horizontalPaddingPercentage = 0.03;
  static const double verticalPaddingPercentage = 0.01;
  static const double searchHorizontalPaddingPercentage = 0.04;
  static const double searchVerticalPaddingPercentage = 0.04;
  static const double searchBarHeightPercentage = 0.08;
  static const double searchBarHeightBase = 48.0;
  static const double cardVerticalPaddingPercentage = 0.015;
  static const double dividerVerticalPaddingPercentage = 0.01;
  static const double switchButtonPaddingPercentage = 0.015;

  static const double horizontalMarginPercentage = 0.05;
  static const double cardHorizontalMarginPercentage = 0.03;
  static const double cardVerticalMarginPercentage = 0.015;

  static const double defaultSpacingPercentage = 0.02;
  static const double bottomNavigationSpacingPercentage = 0.03;
  static const double loadingTextSpacingPercentage = 0.03;
  static const double smallSpacingPercentage = 0.015;
  static const double dividerHeightPercentage = 0.005;

  static const double borderRadiusPercentage = 0.1;
  static const double searchBorderRadiusPercentage = 0.08;
  static const double ratingBorderRadiusPercentage = 0.03;

  static const Duration switcherAnimationDuration = Duration(milliseconds: 300);
  static const Duration buttonAnimationDuration = Duration(milliseconds: 200);
  static const Curve buttonAnimationCurve = Curves.easeInOut;

  static const double navBarMaxWidthPercentage = 0.4;
  static const double navBarMaxWidthBase = 150.0;

  static Color getDefaultIconColor(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
  static Color getDefaultButtonColor(BuildContext context) =>
      Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ?? Colors.blue;
  static Color getDefaultCardColor(BuildContext context) =>
      Theme.of(context).cardTheme.color ?? Colors.white;
  static Color getDefaultAppBarIconColor(BuildContext context) =>
      Theme.of(context).appBarTheme.iconTheme?.color ?? Colors.black;
}
