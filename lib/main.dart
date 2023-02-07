import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemonapp/firebase_options.dart';
import 'package:pokemonapp/routes/custom_routes.dart';
import 'package:pokemonapp/routes/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/auth/auth_cubit.dart';
import 'cubit/pokemon/pokemon_cubit.dart';
import 'utils/color_utils.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<PokemonCubit>(
          create: (context) => PokemonCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: ColorUtils.secondaryColor,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: ColorUtils.secondaryColor),
        ),
        onGenerateRoute: CustomRoutes.allRoutes,
        initialRoute: RouteNames.splash,
      ),
    );
  }
}
