import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemonapp/cubit/pokemon/pokemon_cubit.dart';
import 'package:pokemonapp/main.dart';

import '../routes/route_names.dart';
import '../utils/color_utils.dart';

showErrorDialog(
    {required BuildContext context, required String message}) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Error",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  message,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorUtils.redColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                    color: ColorUtils.whiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      });
}

showLoadingDialog({required BuildContext context}) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CircularProgressIndicator(),
                Text(
                  "Loading...",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ],
            ));
      });
}

showSuccessDialog(
    {required BuildContext context,
    required String message,
    required onPressed}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Success",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                message,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorUtils.greenColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text(
              'OK',
              style: TextStyle(
                  color: ColorUtils.whiteColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );
    },
  );
}

showLogoutDialog({required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  "Are you sure you want to logout?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorUtils.greenColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: ColorUtils.whiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await prefs.remove('email');
                context.read<PokemonCubit>().resetOffSet();
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.login, (Route<dynamic> route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorUtils.redColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                    color: ColorUtils.whiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      });
}
