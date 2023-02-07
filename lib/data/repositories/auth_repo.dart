import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokemonapp/widgets/custom_dialog.dart';

class AuthRepository {
  userRegister(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrorDialog(
            context: context, message: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showErrorDialog(
            context: context,
            message: 'The account already exists for that email.');
      }
    } catch (e) {
      showErrorDialog(context: context, message: e.toString());
    }
  }

  userLogin(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorDialog(
            context: context, message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showErrorDialog(
            context: context,
            message: 'Wrong password provided for that user.');
      }
    } catch (e) {
      showErrorDialog(context: context, message: e.toString());
    }
  }
}
