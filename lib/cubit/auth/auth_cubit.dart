import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemonapp/main.dart';
import 'package:pokemonapp/routes/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/auth_repo.dart';
import '../../widgets/custom_dialog.dart';
import '../pokemon/pokemon_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthState(
            isLoading: false,
            email: TextEditingController(),
            isLoginPasswordVisible: false,
            isRegisterPasswordVisible: false,
            password: TextEditingController()));

  final repository = AuthRepository();

  toggleRegisterPasswordVisibility() {
    emit(state.copyWith(
        isRegisterPasswordVisible: !state.isRegisterPasswordVisible!));
  }

  toggleLoginPasswordVisibility() {
    emit(
        state.copyWith(isLoginPasswordVisible: !state.isLoginPasswordVisible!));
  }

  signUp(BuildContext context) {
    emit(state.copyWith(isLoading: true));
    showLoadingDialog(context: context);
    repository
        .userRegister(
            context: context,
            email: state.email.text,
            password: state.password.text)
        .then((result) async {
      if (result != null) {
        state.email.clear();
        state.password.clear();
        showSuccessDialog(
            context: context,
            message: "User created Successfully",
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, RouteNames.login);
            });
      }
      emit(state.copyWith(isLoading: false));
    });
  }

  login(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    showLoadingDialog(context: context);
    repository
        .userLogin(
            context: context,
            email: state.email.text,
            password: state.password.text)
        .then((result) async {
      if (result != null) {
        await prefs.setString('email', state.email.text);
        state.email.clear();
        state.password.clear();

        Navigator.pushNamedAndRemoveUntil(context, RouteNames.home, (route) {
          return false;
        });
      }
      emit(state.copyWith(isLoading: false));
    });
  }

  saveDataInShared(result) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('email', result.email);
  }
}
