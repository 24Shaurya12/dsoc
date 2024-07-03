import 'package:flutter/material.dart';
import 'package:my_app/classes/my_home_model.dart';
import 'package:my_app/pages/welcome_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/registration_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:my_app/classes/my_cart_model.dart';
import 'package:my_app/pages/add_product_page.dart';
import 'package:my_app/pages/cart_page.dart';


void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context) => MyProductsListModel()),
    ChangeNotifierProvider(create: (context) => MyCartListModel()),
  ],
  child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      initialRoute: '/',
      routes: {
        '/welcome_page': (context) => const WelcomePage(),
        '/login_page': (context) => const LoginPage(),
        '/registration_page': (context) => const SignUpPage(),
        '/home_page': (context) => const HomePage(),
        '/add_product_page': (context) => const AddProductPage(),
        '/cart_page': (context) => const CartPage(),
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
