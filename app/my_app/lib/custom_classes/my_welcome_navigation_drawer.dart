import 'package:flutter/material.dart';
import 'package:my_app/custom_classes/my_drawer_tile.dart';

class MyWelcomeDrawer extends StatelessWidget {
  const MyWelcomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 32, 55, 100),
      child: ListView(
        padding: const EdgeInsets.only(top: 70),
        children: const [
          MyDrawerTile(
            Icons.login,
            'Login',
            '/login_page',
          ),
          MyDrawerTile(
            Icons.app_registration,
            'Sign Up',
            '/registration_page',
          ),
        ],
      ),
    );
  }
}
