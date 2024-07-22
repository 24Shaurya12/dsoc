import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  // Future<void> _preloadLogo() async {
  //   precacheImage(const AssetImage('assets/logo.png'), context);
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: MySplashColumn(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data! == true) {
            Timer(
              const Duration(seconds: 2),
              () {
                Navigator.pushReplacementNamed(
                  context,
                  '/home_page',
                );
              },
            );
          } else {
            Timer(
              const Duration(seconds: 2),
              () {
                Navigator.pushReplacementNamed(
                  context,
                  '/welcome_page',
                );
              },
            );
          }
          return const Scaffold(
            body: MySplashColumn(),
          );
        }
      },
    );
  }

  Future<bool> getLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool("isLoggedIn");
    if (isLoggedIn == true) {
      return true;
    }
    return false;
  }
}

class MySplashColumn extends StatelessWidget {
  const MySplashColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/dev_club_logo.png'),
                  width: screenSize.width * 0.8,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'IPoS App',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            'Made by Shaurya Agarwal',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
