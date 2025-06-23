import 'package:flutter/material.dart';
import 'package:src/common/constants/app_colors.dart';
import 'package:src/common/constants/app_text_styles.dart';
import 'package:src/common/constants/routes.dart';
import 'package:src/common/widgets/multi_text_button.dart';
import 'package:src/common/widgets/primary_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20.0),

          Expanded(
            child: Container(
              child: Image.asset(
                'assets/images/logo_01.png',
                fit: BoxFit.contain,
                width: 600.0,
                height: 600.0,
              ),
            ),
          ),

          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/carteira_01.png',
                fit: BoxFit.contain,
                width: 250.0,
                height: 250.0,
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 16.0,
              bottom: 2.0,
            ),
            child: PrimaryButton(
              text: 'Criar',
              onPressed: () {
                Navigator.pushNamed(context, NamedRouters.signUp);
              },
            ),
          ),
          const SizedBox(height: 0.0),

          MultiTextButton(
            onPressed: () => Navigator.pushNamed(context, NamedRouters.signIn),

            children: [
              Text(
                'Já possui uma conta? ',
                style: AppTextStyles.SmallText.copyWith(color: AppColors.cinza),
              ),

              Text(
                'Entrar',
                style: AppTextStyles.SmallText.copyWith(
                  color: AppColors.amarelo,
                ),
              ),
            ],
          ),

          const SizedBox(height: 60.0),
        ],
      ),
    );
  }
}

// Exemplo de próxima página
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Próxima Página')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Voltar para a página anterior
            Navigator.pop(context);
          },
          child: const Text('Voltar'),
        ),
      ),
    );
  }
}
