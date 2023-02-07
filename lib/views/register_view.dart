import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pokemonapp/cubit/auth/auth_cubit.dart';
import 'package:pokemonapp/routes/route_names.dart';
import 'package:pokemonapp/utils/color_utils.dart';

import '../widgets/custom_textfield.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.bgColor,
        body: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      const Text(
                        textAlign: TextAlign.center,
                        "Register",
                        style: TextStyle(
                            fontSize: 46.1,
                            fontWeight: FontWeight.bold,
                            color: ColorUtils.whiteColor),
                      ),
                      const SizedBox(height: 5.0),
                      const Text(
                        textAlign: TextAlign.center,
                        "Sign up to continue.",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: ColorUtils.whiteColor),
                      ),
                      const SizedBox(height: 10.0),
                      customFormTextField(
                          labelText: "Email",
                          name: "email",
                          hintText: "abc@gmail.com",
                          controller: context.read<AuthCubit>().state.email,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ])),
                      BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                        return customFormTextField(
                            labelText: "Password",
                            name: "password",
                            hintText: "********",
                            obscureText:
                                state.isRegisterPasswordVisible! ? false : true,
                            controller:
                                context.read<AuthCubit>().state.password,
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.isRegisterPasswordVisible!
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                color: ColorUtils.whiteColor,
                              ),
                              onPressed: () {
                                context
                                    .read<AuthCubit>()
                                    .toggleRegisterPasswordVisibility();
                              },
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(6),
                            ]));
                      }),
                      const SizedBox(height: 50),
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorUtils.secondaryColor,
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().signUp(context);
                              }
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        textAlign: TextAlign.center,
                        "Already Have Account?",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: ColorUtils.whiteColor),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthCubit>().state.email.clear();
                          context.read<AuthCubit>().state.password.clear();
                          Navigator.pushReplacementNamed(
                              context, RouteNames.login);
                        },
                        child: const Text(
                          textAlign: TextAlign.center,
                          "Login !",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: ColorUtils.whiteColor),
                        ),
                      )
                    ])),
          ),
        ));
  }
}
