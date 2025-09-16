import 'package:flutter/material.dart';
// import 'package:minimal_social/pages/theme/light_mode.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextfield({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: const Color.fromARGB(255, 78, 78, 78)),
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(255, 31, 52, 57)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      obscureText: obscureText,
    );
  }
}
