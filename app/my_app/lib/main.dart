import 'package:flutter/material.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/registration_page.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      initialRoute: '/',
      routes: {
        '/home_page': (context) => const HomePage(),
        '/login_page': (context) => const LoginPage(),
        '/registration_page': (context) => const SignUpPage(),
      },
      theme: ThemeData(
          textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white)
          )
      ),
      color: Colors.green,
      home: const HomePage(),
    );
  }
}
