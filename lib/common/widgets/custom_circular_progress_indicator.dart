import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  const CustomCircularProgressIndicator({Key? key, this.color})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color ?? AppColors.iceWhite),
    );
  }
}
