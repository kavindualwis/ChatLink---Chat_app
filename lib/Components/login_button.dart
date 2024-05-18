import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.image,
  });

  final String text;
  final Function()? onTap;
  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 79, 79, 79),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 60),
            Image.asset(
              image,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
