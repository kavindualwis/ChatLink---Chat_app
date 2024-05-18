// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  final Icon icon;
  final String text;
  void Function()? ontap;

  DrawerTile({
    super.key,
    required this.icon,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.only(left: 25, top: 25, bottom: 10),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
