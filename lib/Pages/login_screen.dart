// ignore_for_file: use_build_context_synchronously, unused_catch_clause

import 'package:chat_link/Components/constants.dart';
import 'package:chat_link/Components/login_button.dart';
import 'package:chat_link/Components/my_button.dart';
import 'package:chat_link/Components/my_textfiled.dart';
import 'package:chat_link/Pages/chat_page.dart';
import 'package:chat_link/Pages/forgot_pswd.dart';
import 'package:chat_link/Pages/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //User sign in
  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: purple,
          ),
        );
      },
    );

    //try sign in
    try {
      //try sign in
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //Save user info in a seperate doc
      _firestore.collection("users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': emailController.text,
        },
      );

      //pop the circle
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatPage(),
        ),
      );
      FocusScope.of(context).unfocus();
      //Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Signed ${emailController.text} successfully!',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: purple,
        ),
      );
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);

      //show alert dialog with error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Sign in Failed',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              'Username Or Password Incorrect',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
  // //Login method
  // void signin(BuildContext context) async {
  //   //auth service
  //   final authService = AuthService();

  //   //try login
  //   try {
  //     authService.signInWithEmailPassword(
  //       emailController.text,
  //       passwordController.text,
  //     );
  //   }

  //   //catch any errors
  //   on FirebaseAuthException catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Sign in failed'),
  //         content: const Text('Incorrect Username Or Password'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {},
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    // Clear text editing controllers
    emailController.dispose();
    passwordController.dispose();

    // Unfocus the keyboard
    FocusScope.of(context).unfocus();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Welcome Back.',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Let's sign you in",
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),

                  //Username
                  MyTextField(
                    controller: emailController,
                    hintText: 'Phone,email or username',
                    preIcons: const Icon(Icons.person_2_outlined),
                    obscureText: false,
                  ),

                  const SizedBox(height: 30),

                  //password
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    preIcons: const Icon(Icons.lock_outline),
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ForgotPassword(),
                              transition: Transition.downToUp);
                        },
                        child: Text(
                          'Recover Password',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  //Sign in button
                  MyButton(
                    color: purple,
                    text: 'Sign In',
                    onTap: signUserIn,
                  ),

                  const SizedBox(height: 40),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 250),
                        child: const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 250),
                        child: const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 100),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "or Continue with",
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  LoginButton(
                    image: 'images/google.png',
                    color: Colors.transparent,
                    text: 'Continue with Google',
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),

                  LoginButton(
                    image: 'images/facebook.png',
                    color: Colors.transparent,
                    text: 'Continue with Facebook',
                    onTap: () {},
                  ),
                  const SizedBox(height: 60),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => const RegisterPage(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        child: Text(
                          "Register",
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
