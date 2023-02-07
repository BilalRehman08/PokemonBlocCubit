import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils/color_utils.dart';

Widget customFormTextField({
  required String name,
  required String labelText,
  required String hintText,
  bool obscureText = false,
  IconButton? suffixIcon,
  required TextEditingController controller,
  required String? Function(String?)? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          labelText,
          style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: ColorUtils.whiteColor),
        ),
      ),
      FormBuilderTextField(
        name: name,
        controller: controller,
        style: const TextStyle(color: ColorUtils.whiteColor),
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          filled: true,
          focusColor: const Color(0xff737373),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: const Color(0xff737373),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
      const SizedBox(height: 5.0),
    ],
  );
}
