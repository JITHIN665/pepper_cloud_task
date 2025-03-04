import 'package:flutter/material.dart';
import 'package:pepper_cloud_task/theme/colors.dart';

AppColors appColor(context) => Theme.of(context).extension<AppColors>()!;

ThemeData getAppTheme(BuildContext context) {
  return ThemeData(
    extensions: const <ThemeExtension<AppColors>>[
      AppColors(
        primaryGradient: [
          Color(0xFF3A49F9),
          Color(0xFF9C2CF3),
        ],
        background: Color(0xffF2F5FF),
        primary: Color(0xffAA6D10),
        primaryText: Color(0xff202123),
        secondaryText: Color(0xff4A4A4A),
        text: Color(0xffffffff),
        subText: Color(0xff737373),
        errorText: Color(0xffdb292a),
        buttonColorRed: Color(0xffB14747),
        lightGreen: Color(0xff059E90),
      )
    ],
    fontFamily: 'Manrope',
  );
}
