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
        colorScheme: ColorScheme.fromSeed(
          seedColor:  const Color.fromARGB(255, 16, 44, 87),
          brightness: Brightness.dark,
          // primarySwatch: Colors.amber,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 240, 240, 225),
          suffixIconColor: const Color.fromARGB(255, 200, 190, 100),
          errorStyle: const TextStyle(
            color: Color.fromARGB(255, 218, 192, 102),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              width: 1.0,
              color: Color.fromARGB(255, 218, 192, 102),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              width: 2.0,
              color: Color.fromARGB(255, 218, 192, 102),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.black,
            ),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 32,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          labelLarge: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          labelMedium: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          labelSmall: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 218, 192, 163),
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 16, 44, 87),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 16, 44, 87),
          foregroundColor: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionHandleColor: Color.fromARGB(200, 218, 192, 140),
        )
      ),
      home: const WelcomePage(),
    );
  }
}
