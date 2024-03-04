import 'package:firebase_auth/firebase_auth.dart';

import '../../exception/auth_exception.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      //email-already-exists
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message:
                  'Esse email já utilizado, por favor escolha outro em-mail');
        } else {
          throw AuthException(
              message:
                  'Você se cadastrou no ToDoList pelo google, [pr favor utilize ele para entrar');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }
}
