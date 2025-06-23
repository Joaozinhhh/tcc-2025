import 'package:flutter/material.dart';
import 'package:src/common/constants/app_colors.dart';
import 'package:src/common/constants/app_text_styles.dart';
import 'package:src/common/constants/routes.dart';
import 'package:src/common/utils/validator.dart';
import 'package:src/common/widgets/custom_bottom_sheet.dart';
import 'package:src/common/widgets/custom_circular_progress_indicator.dart';
import 'package:src/common/widgets/custom_text_form_field.dart';
import 'package:src/common/widgets/multi_text_button.dart';
import 'package:src/common/widgets/password_form_field.dart';
import 'package:src/common/widgets/primary_button.dart';
import 'package:src/features/sign_in/sign_in_controller.dart';
import 'package:src/features/sign_in/sign_in_state.dart';
import 'package:src/locator.dart';
import 'dart:developer';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = locator.get<SignInController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is SignInStateLoading) {
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }
      if (_controller.state is SignInStateSuccess) {
        Navigator.pop(context);
        Navigator.restorablePushReplacementNamed(context, NamedRouters.home);
      }

      if (_controller.state is SignInStateError) {
        final error = _controller.state as SignInStateError;
        Navigator.pop(context);
        customModalBottomSheet(
          context,
          content: error.message,
          buttonText: "Tentar novamente",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text(
            'Aplicatico Financeiro',
            textAlign: TextAlign.center,
            style: AppTextStyles.MediumText.copyWith(color: AppColors.cinza),
          ),
          Image.asset('assets/images/logo_01.png'),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _emailController,
                  labelText: "Seu email",
                  hintText: "joao@gmail.com",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "Sua senha",
                  hintText: "*********",
                  validator: Validator.validatePassword,
                  helperText: 'A senha deve ter no mínimo 8 caracteres',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 16.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              text: 'Entrar',
              onPressed: () {
                final valid =
                    _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.signIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                } else {
                  log("erro ao logar");
                }
              },
            ),
          ),
          MultiTextButton(
            onPressed:
                () => Navigator.popAndPushNamed(context, NamedRouters.signUp),
            children: [
              Text(
                'Não possui uma conta? ',
                style: AppTextStyles.SmallText.copyWith(color: AppColors.cinza),
              ),
              Text(
                'Cadastre-se',
                style: AppTextStyles.SmallText.copyWith(
                  color: AppColors.azul_escuro,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
