//refactoring guru

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:src/features/sign_up/sign_up_state.dart';

class SignUpController extends ChangeNotifier {
  SignUpState _state = SignUpInitialSate();

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> doSignUp() async {
    _changeState(SignUpLoadingSate());

    try {
      await Future.delayed(const Duration(seconds: 2));

      // throw Exception("Erro ao cadastrar usuário");
      log("usario criado com sucesso");

      _changeState(SignUpSuccessSate());

      return true;
    } catch (e) {
      _changeState(SignUpErrorSate());
      return false;
    }
  }
}
