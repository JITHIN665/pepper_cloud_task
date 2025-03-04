import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};

class AppColors extends ThemeExtension<AppColors> {
  final Color? background;
  final Color? primary;
  final Color? primaryText;
  final Color? secondaryText;
  final Color? text;
  final Color? subText;
  final Color? errorText;
  final List<Color>? primaryGradient;
  final Color? buttonColorRed;
  final Color? lightGreen;

  const AppColors({
    required this.background,
    required this.primary,
    required this.primaryText,
    required this.secondaryText,
    required this.text,
    required this.subText,
    required this.errorText,
    required this.primaryGradient,
    required this.buttonColorRed,
    required this.lightGreen,
  });

  @override
  AppColors copyWith({
    Color? background,
    Color? primary,
    Color? primaryText,
    Color? secondaryText,
    Color? text,
    Color? subText,
    Color? errorText,
    List<Color>? primaryGradient,
    Color? buttonColorRed,
    Color? textFieldBackground,
    Color? timerColor,
    Color? lightWhite,
    Color? fullWhite,
    Color? lightGreen,
  }) {
    return AppColors(
      background: background ?? this.background,
      primary: primary ?? this.primary,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      text: text ?? this.text,
      subText: subText ?? this.subText,
      errorText: errorText ?? this.errorText,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      buttonColorRed: buttonColorRed ?? this.buttonColorRed,
      lightGreen: lightGreen ?? this.lightGreen,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      background: Color.lerp(background, other.background, t),
      primary: Color.lerp(primary, other.primary, t),
      primaryText: Color.lerp(primaryText, other.primaryText, t),
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t),
      text: Color.lerp(text, other.text, t),
      subText: Color.lerp(subText, other.subText, t),
      errorText: Color.lerp(errorText, other.errorText, t),
      buttonColorRed: Color.lerp(buttonColorRed, buttonColorRed, t),
      primaryGradient: primaryGradient,
      lightGreen: Color.lerp(lightGreen, other.lightGreen, t),
    );
  }
}
