// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.onTabChange,
  }) : super(key: key);

  final void Function(int)? onTabChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          Colors.transparent, // Set the color of the container to transparent
      child: GNav(
        activeColor: Colors.grey.shade700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Theme.of(context).colorScheme.primary,
        tabBorderRadius: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        onTabChange: (value) => onTabChange!(value),
        tabs: [
          GButton(
            duration: const Duration(milliseconds: 500),
            icon: Icons.chat_rounded,
            iconActiveColor: Colors.white,
            text: 'Chats',
            textStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            gap: 10,
          ),
          GButton(
            duration: const Duration(milliseconds: 500),
            icon: Icons.settings_outlined,
            iconActiveColor: Colors.white,
            text: 'Settings',
            textStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            gap: 10,
          ),
        ],
      ),
    );
  }
}
