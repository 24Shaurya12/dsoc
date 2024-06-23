import 'package:flutter/material.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/my_app_bar.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
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
