part of 'auth_cubit.dart';

class AuthState {
  final TextEditingController email;
  final TextEditingController password;
  final bool? isRegisterPasswordVisible;
  final bool? isLoginPasswordVisible;
  final bool? isLoading;

  AuthState({
    required this.email,
    required this.password,
    this.isRegisterPasswordVisible,
    this.isLoginPasswordVisible,
    this.isLoading,
  });

  AuthState copyWith({
    TextEditingController? email,
    TextEditingController? password,
    bool? isRegisterPasswordVisible,
    bool? isLoginPasswordVisible,
    bool? isLoading,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isRegisterPasswordVisible:
          isRegisterPasswordVisible ?? this.isRegisterPasswordVisible,
      isLoginPasswordVisible:
          isLoginPasswordVisible ?? this.isLoginPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
