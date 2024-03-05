import 'package:flutter/material.dart';

import '../../../exception/auth_exception.dart';
import '../../../services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      error = null;
      success = false;
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        success = true;
      } else {
        error = 'Erro ao registrar o usuário';
      }
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
