import 'package:flutter/material.dart';
import 'package:src/common/constants/app_colors.dart';
import 'package:src/common/constants/app_text_styles.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.azul_claro, AppColors.azul_claro],
          ),
        ),
        child: Text(
          'FinancyControl',
          style: AppTextStyles.bigText.copyWith(color: AppColors.branco),
        ),
      ),
    );
  }
}
