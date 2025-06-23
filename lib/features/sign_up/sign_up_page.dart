import 'package:flutter/material.dart';
import 'package:src/common/constants/app_colors.dart';
import 'package:src/common/constants/app_text_styles.dart';
import 'package:src/common/constants/routes.dart';
import 'package:src/common/utils/uppercase_text_formatter.dart';
import 'package:src/common/utils/validator.dart';
import 'package:src/common/widgets/custom_bottom_sheet.dart';
import 'package:src/common/widgets/custom_circular_progress_indicator.dart';
import 'package:src/common/widgets/multi_text_button.dart';
import 'package:src/common/widgets/password_form_field.dart';
import 'package:src/common/widgets/primary_button.dart';
import 'package:src/common/widgets/custom_text_form_field.dart';
import 'package:src/features/sign_up/sign_up_state.dart';
import 'package:src/features/sign_up/sign_up_controller.dart';
import 'package:src/locator.dart';
import 'dart:developer';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  //gpt

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = locator.get<SignUpController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is SignUpLoadingState) {
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }
      if (_controller.state is SignUpSuccessState) {
        Navigator.pop(context);
        Navigator.restorablePushReplacementNamed(context, NamedRouters.home);
      }
      if (_controller.state is SignUpErrorState) {
        final error = _controller.state as SignUpErrorState;
        Navigator.pop(context);
        customModalBottomSheet(
          context,
          content: error.message,
          buttonText: 'Tentar novamente',
        );
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
                  controller: _nameController,
                  labelText: "Seu nome:",
                  hintText: "JOAO ",
                  inputFormatters: [UpperCaseTextInputFormatter()],
                  validator: Validator.validateName,
                ),

                CustomTextFormField(
                  controller: _emailController,
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
                  _controller.signUp(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                } else {
                  log("erro ao logar");
                }
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
