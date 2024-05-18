import 'package:chat_link/Components/mydrawer_tile.dart';
import 'package:chat_link/Pages/login_screen.dart';
import 'package:chat_link/Pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void signUserout() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                duration: const Duration(seconds: 2),
                child: Image.asset(
                  'images/playstore.png',
                ),
              ),
              //CHATS list tile
              DrawerTile(
                icon: Icon(
                  Icons.chat_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                text: 'Chats',
                ontap: () {
                  Navigator.pop(context);
                },
              ),

              //AVATAR
              DrawerTile(
                icon: Icon(
                  Icons.person_outline_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                text: 'Avatar',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              //PRIVACY
              DrawerTile(
                icon: Icon(
                  Icons.privacy_tip_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                text: 'Privacy',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              //NOTIFICATIONS
              DrawerTile(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                text: 'Notifications',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              //DARKMODE
              DrawerTile(
                icon: Icon(
                  Icons.dark_mode_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                text: 'Darkmode',
                ontap: () {
                  Navigator.pop(context);
                  Get.to(
                    () => const SettingsPage(),
                    transition: Transition.leftToRight,
                    duration: const Duration(milliseconds: 600),
                  );
                },
              ),
              //App Language
              DrawerTile(
                icon: Icon(
                  Icons.language,
                  color: Theme.of(context).colorScheme.primary,
                ),
                text: 'App Language',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              //Help
              DrawerTile(
                icon: Icon(
                  Icons.help_outline_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                text: 'Help',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              //DARKMODE
              DrawerTile(
                icon: Icon(
                  Icons.person_4_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                text: 'Invite a friend',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              //DARKMODE
              DrawerTile(
                icon: Icon(
                  Icons.update_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                text: 'App updates',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),

          //Logut button
          DrawerTile(
            icon: Icon(
              Icons.logout_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            text: 'Logout',
            ontap: signUserout,
          ),
        ],
      ),
    );
  }
}
