import 'package:flutter/material.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/registeration_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      body: Column(
        children: [
          const SizedBox(height: 45,),
          const Row(
            children: [
              Expanded(child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30), 'DSOC'))),
              SizedBox(width: 70),
              Expanded(child: Icon(Icons.menu, color: Colors.white, size: 40,)),
            ],
          ),
          Container(padding: const EdgeInsets.all(45.0), child: const Image(image: AssetImage('assets/logo.png'))),
          const Text(textAlign: TextAlign.center,'Hello, Welcome!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          const SizedBox(height: 20,),
          const Text('Welcome to DSOC 2024', textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
          const SizedBox(height: 50,),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
              child: const Text('Login', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ),
          const SizedBox(height: 30,),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
              child: const Text('Sign Up', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
              },
            ),
          ),

        ],
      ),
    );
  }
}