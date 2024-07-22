import 'package:flutter/material.dart';
import 'package:my_app/models/my_home_model.dart';
import 'package:my_app/models/my_user_model.dart';
import 'package:my_app/pages/auth_pages/login_page.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/pages/auth_pages/splash_screen.dart';
import 'package:my_app/pages/auth_pages/welcome_page.dart';
import 'package:my_app/pages/auth_pages/registration_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/my_cart_model.dart';
import 'package:my_app/pages/add_new_product_page.dart';
import 'package:my_app/pages/cart_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:my_app/variables/variables.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProductsListModel()),
        ChangeNotifierProvider(create: (context) => MyCartListModel()),
        ChangeNotifierProvider(create: (context) => MyUserInfoModel())
      ],
      child: const MyApp(),
    ),
  );
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
          seedColor: dsocBlue,
          brightness: Brightness.dark,
          // primarySwatch: Colors.amber,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: dsocWhite,
          suffixIconColor: dsocSuffixYellow,
          errorStyle: const TextStyle(
            color: dsocBorderYellow,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              width: 1.0,
              color: dsocBorderYellow,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              width: 2.0,
              color: dsocBorderYellow,
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
          bodySmall: TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: dsocYellow,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        scaffoldBackgroundColor: dsocBlue,
        appBarTheme: const AppBarTheme(
          backgroundColor: dsocBlue,
          foregroundColor: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionHandleColor: Color.fromARGB(200, 218, 192, 140),
        ),
      ),
      home: const HomePage(),
    );
  }
}