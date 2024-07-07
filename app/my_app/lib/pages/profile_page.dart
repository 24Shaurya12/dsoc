import 'package:flutter/material.dart';
import 'package:my_app/models/my_user_model.dart';
import 'package:provider/provider.dart';
import 'package:my_app/custom_classes/my_app_bar.dart';
import 'package:my_app/custom_classes/my_navigation_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      appBar: const MyAppBar(),
      endDrawer: const MyEndDrawer(),
      body: Consumer<MyUserInfoModel>(
        builder: (context, userInfo, child) {
          return DefaultTextStyle(
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('User Name: ${userInfo.userName}'),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('User Email: ${userInfo.userEmail}'),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          'User Phone Number: ${userInfo.userPhoneNo.toString()}'),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 218, 192, 163)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/welcome_page');
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
