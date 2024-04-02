import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw AuthException(message: 'Login ou senha inválidos');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message!);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String> loginMethods = [];
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        // final GoogleSignInAuthentication? googleAuth =
        //     await googleUser?.authentication;
        // // ignore: deprecated_member_use
        // loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(
        //   googleUser.email,
        // );
        // if (loginMethods.contains('password')) {
        //   throw AuthException(
        //     message: 'Você utilizou o e-mail para se cadastrar',
        //   );
        // } else {
        final googleAuth = await googleUser.authentication;
        final firebaseCredential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        var userCredential =
            await _firebaseAuth.signInWithCredential(firebaseCredential);
        return userCredential.user;
        // }
      }
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
          message: '''
          Login inválido você se registrou no TodoList com os seguintes provedores: 
          ${loginMethods.join(', ')}
          ''',
        );
      } else {
        throw AuthException(message: e.message ?? 'Erro ao realizar login');
      }
    }
  }
}
