import 'package:chat_link/Components/constants.dart';
import 'package:chat_link/Components/my_button.dart';
import 'package:chat_link/Pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: LottieBuilder.asset(
                  'animations/Animation - 1.json',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  animate: true,
                ),
              ),
              Text(
                'Connect With Others',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Where connections flourish and conversations spark! Dive into a world of seamless communication, where every link brings you closer to your community. Get ready to engage, share, and explore with Chat Link. Let's link up and chat away!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              MyButton(
                color: purple,
                onTap: () {
                  Get.to(
                    () => const LoginPage(),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                text: 'Get Started',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
