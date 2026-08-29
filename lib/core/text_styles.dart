import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/core/app_colors.dart';

String fontFamily = 'RobotoMono';

abstract class AppStyles {
  static TextStyle styleRegular16(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleRegular24(BuildContext context, {Color? color}) {
    return TextStyle(
      color: color ?? AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold20(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleMedium24(BuildContext context, {Color? color}) {
    return TextStyle(
      color: color ?? AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
    );
  }
}

// sacleFactor
// responsive font size
// (min , max) fontsize
double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < 600) {
    // 500 --599
    // mobile
    return width / 400;
  } else if (width < 900) {
    //800
    // tablet
    return width / 700;
  } else {
    // desktop
    return width / 1000;
  }
}
