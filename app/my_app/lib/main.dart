import 'package:flutter/material.dart';
import 'package:my_app/models/my_home_model.dart';
import 'package:my_app/models/my_user_model.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/pages/welcome_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/registration_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/my_cart_model.dart';
import 'package:my_app/pages/add_product_page.dart';
import 'package:my_app/pages/cart_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MyProductsListModel()),
    ChangeNotifierProvider(create: (context) => MyCartListModel()),
    ChangeNotifierProvider(create: (context) => MyUserInfoModel())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      initialRoute: '/',
      routes: {
        '/welcome_page': (context) => const WelcomePage(),
        '/login_page': (context) => const LoginPage(),
        '/registration_page': (context) => const SignUpPage(),
        '/home_page': (context) => const HomePage(),
        '/add_product_page': (context) => const AddProductPage(),
        '/cart_page': (context) => const CartPage(),
        '/profile_page': (context) => const ProfilePage(),
      },
      theme: ThemeData(
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.white))),
      color: Colors.green,
      home: const HomePage(),
    );
  }
}
