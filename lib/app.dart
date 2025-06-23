import 'package:flutter/material.dart';
import 'package:src/common/constants/routes.dart';
import 'package:src/common/models/transaction_model.dart';
import 'package:src/features/home/home_page_view.dart';
import 'package:src/common/themes/default_theme.dart';
import 'package:src/features/onboarding/onboarding_page.dart';
import 'package:src/features/profile/profile_page.dart';
import 'package:src/features/sign_in/sign_in_page.dart';
import 'package:src/features/sign_up/sign_up_page.dart';
import 'package:src/features/splash/splash_page.dart';
import 'package:src/features/stats/stats_page.dart';
import 'package:src/features/transactions/transaction_page.dart';
import 'package:src/features/wallet/wallet_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme().defaultTheme,
      initialRoute: NamedRouters.splash,
      routes: {
        NamedRouters.initial: (context) => const OnboardingPage(),
        NamedRouters.splash: (context) => const SplashPage(),
        NamedRouters.signUp: (context) => const SignUpPage(),
        NamedRouters.signIn: (context) => const SignInPage(),
        NamedRouters.home: (context) => const HomePageView(),
        NamedRouters.stats: (context) => const StatsPage(),
        NamedRouters.wallet: (context) => const WalletPage(),
        NamedRouters.profile: (context) => const ProfilePage(),
        NamedRouters.transaction: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return TransactionPage(
            transaction: args != null ? args as TransactionModel : null,
          );
        },
      },
    );
  }
}
