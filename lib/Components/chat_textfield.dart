// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatTextField extends StatelessWidget {
  ChatTextField({
    super.key,
    required this.suffixIcon,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.focusNode,
  });

  final String hintText;
  final Icon suffixIcon;
  void Function()? onTap;
  bool obscureText;
  final controller;
  final FocusNode? focusNode;

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
          focusNode: focusNode,
          obscureText: obscureText,
          maxLines: null,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: suffixIcon,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
