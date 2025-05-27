import 'package:flutter/material.dart';
import 'package:src/common/constants/app_colors.dart';
import 'package:src/common/constants/app_text_styles.dart';
import 'package:src/common/utils/uppercase_text_formatter.dart';
import 'package:src/common/utils/validator.dart';
import 'package:src/common/widgets/custom_bottom_sheet.dart';
import 'package:src/common/widgets/custom_circular_progress_indicator.dart';
import 'package:src/common/widgets/multi_text_button.dart';
import 'package:src/common/widgets/password_form_field.dart';
import 'package:src/common/widgets/primary_button.dart';
import 'package:src/common/widgets/custom_text_form_field.dart';
import 'package:src/features/onboarding/onboarding_page.dart';
import 'package:src/features/sign_up/sign_up_state.dart';
import 'package:src/features/sign_up/sign_up_controller.dart';
import 'dart:developer';

import 'package:src/features/sign_up/sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  //gpt

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _controller = SignUpController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is SignUpLoadingSate) {
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }
      if (_controller.state is SignUpSuccessSate) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => Scaffold(body: Center(child: Text("NOva tela"))),
          ),
        );
      }
      if (_controller.state is SignUpErrorSate) {
        Navigator.pop(context);
        customModalBottomSheet(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: 0,
              bottom: 12.0,
            ), // diminui o espaço externo
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 0,
            ), // diminui o espaço interno
            decoration: BoxDecoration(
              color: AppColors.azul_claro,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(19.0),
                bottomRight: Radius.circular(19.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vamos',
                    style: AppTextStyles.bigText.copyWith(
                      color: AppColors.branco,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'criar sua',
                    style: AppTextStyles.bigText.copyWith(
                      color: AppColors.branco,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'conta',
                    style: AppTextStyles.bigText.copyWith(
                      color: AppColors.branco,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: "Seu nome:",
                  hintText: "JOAO ",
                  inputFormatters: [UpperCaseTextInputFormatter()],
                  validator: Validator.validateName,
                ),

                CustomTextFormField(
                  labelText: "Seu email",
                  hintText: "joao@gmail.com",
                  validator: Validator.validateEmail,
                ),

                PasswordFormField(
                  controller: _passwordController,
                  labelText: 'senha',
                  hintText: 'senha',
                  validator: Validator.validatePassword,
                  helperText: 'A senha deve ter no mínimo 8 caracteres',
                ),

                PasswordFormField(
                  labelText: 'reescreva a senha',
                  hintText: 'senha',
                  validator:
                      (value) => Validator.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
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
              text: 'Cadastrar',
              onPressed: () {
                final valid =
                    _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.doSignUp();
                } else {
                  log("erro ao logar");
                }
              },
            ),
          ),
          const SizedBox(height: 0.0),

          MultiTextButton(
            onPressed: () => print('Botão pressionado'),

            children: [
              Text(
                'Já possui uma conta? ',
                style: AppTextStyles.SmallText.copyWith(color: AppColors.cinza),
              ),

              Text(
                'Entrar',
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
