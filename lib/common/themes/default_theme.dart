import 'package:flutter/material.dart';
import 'package:src/common/constants/app_colors.dart';
import 'package:src/common/constants/app_text_styles.dart';

class CustomTheme {
  CustomTheme._();

  factory CustomTheme() {
    return CustomTheme._();
  }

  ThemeData get defaultTheme {
    const defaultBorder = OutlineInputBorder(borderSide: BorderSide(color: AppColors.azul_claro));

    return ThemeData(
      colorScheme: const ColorScheme.light(primary: AppColors.azul_escuro),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(foregroundColor: AppColors.iceWhite, backgroundColor: AppColors.azul_claro),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: AppColors.azul_escuro)),
      tabBarTheme: const TabBarTheme(indicator: BoxDecoration(border: Border())),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: AppTextStyles.inputLabelText.copyWith(color: AppColors.grey),
        hintStyle: AppTextStyles.inputHintText.copyWith(color: AppColors.cinza),
        focusedBorder: defaultBorder,
        enabledBorder: defaultBorder,
        disabledBorder: defaultBorder,
        errorBorder: defaultBorder.copyWith(borderSide: const BorderSide(color: AppColors.error)),
        focusedErrorBorder: defaultBorder.copyWith(borderSide: const BorderSide(color: AppColors.error)),
      ),
    );
  }
}
