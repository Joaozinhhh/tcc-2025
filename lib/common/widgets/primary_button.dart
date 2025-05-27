import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const PrimaryButton({Key? key, this.onPressed, required this.text})
    : super(key: key);

  final BorderRadius _borderRadius = const BorderRadius.all(
    Radius.circular(25.0),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        height: 50.0,
        width: 250.0,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                onPressed != null
                    ? [AppColors.azul_escuro, AppColors.azul_claro]
                    : [AppColors.azul_escuro, AppColors.azul_claro],
          ),
        ),
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: onPressed,
          child: Align(
            child: Text(
              text,
              style: AppTextStyles.MediumText.copyWith(color: AppColors.branco),
            ),
          ),
        ),
      ),
    );
  }
}
