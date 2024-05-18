// ignore_for_file: use_build_context_synchronously, unused_catch_clause
import 'package:chat_link/Components/constants.dart';
import 'package:chat_link/Components/login_button.dart';
import 'package:chat_link/Components/my_button.dart';
import 'package:chat_link/Components/my_textfiled.dart';
import 'package:chat_link/Pages/chat_page.dart';
import 'package:chat_link/Pages/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sign up method
  void signUserUp() async {
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

    //try sign up
    try {
      //ccreate user
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
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

        // If sign up is successful, navigate to HomePage
        Navigator.pop(context); // Pop the loading dialog
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatPage(),
          ),
        );
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
      } else {
        // If passwords don't match, show error message
        Navigator.pop(context); // Pop the loading dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Register Failed',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Passwords don't match",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
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
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      //pop the circle
      Navigator.pop(context);
      //show alert box
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Register Failed',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Incorrect Username or Password',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
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
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          'Welcome To ChatLink.',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Let's Register",
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    const SizedBox(height: 15),

                    //Username
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      preIcons: const Icon(Icons.person_2_outlined),
                      obscureText: false,
                    ),

                    const SizedBox(height: 15),

                    //password
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      preIcons: const Icon(Icons.lock_outline),
                      obscureText: true,
                    ),
                    const SizedBox(height: 15),

                    //confirm password
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      preIcons: const Icon(Icons.lock_outline),
                      obscureText: true,
                    ),

                    const SizedBox(height: 40),

                    //Sign in button
                    MyButton(
                      color: purple,
                      text: 'Register',
                      onTap: signUserUp,
                    ),

                    const SizedBox(height: 30),

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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    LoginButton(
                      image: 'images/google.png',
                      color: Colors.transparent,
                      text: 'Continue with Google',
                      onTap: () {},
                    ),
                    const SizedBox(height: 30),

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
                          "Already have an account?",
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
                              () => const LoginPage(),
                              transition: Transition.leftToRight,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                          child: Text(
                            "Login",
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
      ),
    );
  }
}
