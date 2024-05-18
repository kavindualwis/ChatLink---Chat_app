// ignore_for_file: use_key_in_widget_constructors

import 'package:chat_link/Components/msg_tile.dart';
import 'package:chat_link/Components/my_drawer.dart';
import 'package:chat_link/Pages/chat_screen.dart';
import 'package:chat_link/Services/Auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          "ChatLink",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const SafeArea(
        child: MyDrawer(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error occurred'),
              );
            }
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final userName = user['email'];
                final id = user['email'];
                if (user['email'] != _auth.getCurrentUser()!.email) {
                  return MessageTile(
                    userName: id,
                    onTap: () {
                      Get.to(
                        () => ChatScreen(
                          receiverName: userName,
                          receiverID: user['uid'],
                        ),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 600),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
