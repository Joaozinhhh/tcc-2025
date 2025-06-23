import 'package:flutter/material.dart';
import 'package:src/common/constants/app_colors.dart';
import 'package:src/common/constants/app_text_styles.dart';
import 'package:src/common/constants/routes.dart';
import 'package:src/common/extensions/sizes.dart';
import 'package:src/common/widgets/custom_circular_progress_indicator.dart';
import 'package:src/features/splash/splash_controller.dart';
import 'package:src/features/splash/splash_state.dart';
import 'package:src/locator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _splashController = locator.get<SplashController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => Sizes.init(context));
    _splashController.isUserLogged();
    _splashController.addListener(() {
      if (_splashController.state is AuthenticatedUser) {
        Navigator.pushReplacementNamed(context, NamedRouters.home);
      } else if (_splashController.state is UnauthenticatedUser) {
        Navigator.pushReplacementNamed(context, NamedRouters.initial);
      }
    });
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
  }

  void navigateToOnboarding() {
    Navigator.pushReplacementNamed(context, NamedRouters.initial);
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'FinancyControl',
              style: AppTextStyles.bigText.copyWith(color: AppColors.branco),
            ),
            CustomCircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
