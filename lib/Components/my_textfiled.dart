// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.preIcons,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  });

  final String hintText;
  final Icon? preIcons;
  void Function()? onTap;
  bool obscureText;
  final controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 79, 79, 79),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: preIcons,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
