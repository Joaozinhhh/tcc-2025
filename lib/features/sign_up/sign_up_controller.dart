import 'package:flutter/foundation.dart';

import '../../services/auth_service.dart';
import '../../services/graphql_service.dart';
import '../../services/secure_storage.dart';
import 'sign_up_state.dart';

class SignUpController extends ChangeNotifier {
  final AuthService authService;
  final SecureStorage secureStorage;
  final GraphQLService graphQLService;

  SignUpController({
    required this.authService,
    required this.secureStorage,
    required this.graphQLService,
  });

  SignUpState _state = SignUpInitialState();

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _changeState(SignUpLoadingState());

    try {
      final user = await authService.signUp(
        name: name,
        email: email,
        password: password,
      );
      if (user.id != null) {
        await secureStorage.write(key: "CURRENT_USER", value: user.toJson());

        await graphQLService.init();

        _changeState(SignUpSuccessState());
      } else {
        throw Exception();
      }
    } catch (e) {
      _changeState(SignUpErrorState(e.toString()));
    }
  }
}
