import 'package:flutter/material.dart';

import '../utils/image_utils.dart';

class LoadingBlinkingImage extends StatefulWidget {
  final double height;
  final double width;
  const LoadingBlinkingImage({super.key, this.height = 120, this.width = 120});

  @override
  State<LoadingBlinkingImage> createState() => _LoadingBlinkingImageState();
}

class _LoadingBlinkingImageState extends State<LoadingBlinkingImage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller!.repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller!,
          curve: Curves.linear,
        ),
      ),
      child: Image.asset(
        ImageUtils.loadingImage,
        height: 120,
        width: 120,
      ),
    );
  }
}
