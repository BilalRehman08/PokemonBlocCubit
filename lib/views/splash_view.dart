import 'package:flutter/material.dart';
import 'package:pokemonapp/main.dart';
import 'package:pokemonapp/routes/route_names.dart';
import 'package:pokemonapp/utils/image_utils.dart';

import '../utils/color_utils.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    _controller!.forward();
    _controller!.addListener(() {
      if (_controller!.status == AnimationStatus.completed) {
        checkLoginStatus();
      }
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Future checkLoginStatus() async {
    String email = prefs.getString('email') ?? '';
    if (email.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.home, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation!,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ColorUtils.whiteColor,
          child: Center(child: Image.asset(ImageUtils.splashLogo)),
        ),
      ),
    );
  }
}
