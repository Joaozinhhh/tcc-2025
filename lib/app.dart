import 'package:flutter/material.dart';
import 'package:src/common/themes/default_theme.dart';
import 'package:src/features/onboarding/onboarding_page.dart';
import 'package:src/features/sign_up/sign_up_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: defaultTheme, home: const SignUpPage());
  }
}
