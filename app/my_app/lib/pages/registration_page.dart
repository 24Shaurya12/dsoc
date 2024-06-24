import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:my_app/my_app_bar.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'signUp Page',
        // theme: ThemeData(
        //     primaryColor: Colors.green,
        //     appBarTheme: const AppBarTheme(
        //       backgroundColor: Colors.blue,
        //     )
        // ),
        home: Scaffold(
          appBar: MyAppBar(),
          backgroundColor: Color.fromARGB(255, 16, 44, 87),
          body: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text('Create Account Now!', style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),)),
              ),
              RegistrationForm(),
            ],
          )
        )
    );
  }
}


class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNoController = TextEditingController();

  final registrationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
    key: registrationKey,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 25,
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Full Name'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
                child: TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 250, 239),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(),
                    )
                  ),
                ),
              ),
              const Text('Email'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 250, 239),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(),
                      )
                  ),
                ),
              ),
              const Text('Password'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 250, 239),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(),
                      )
                  ),
                ),
              ),
              const Text('Phone No'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 65),
                child: TextFormField(
                  controller: _phoneNoController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 250, 239),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(),
                      )
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {signUp(registrationKey);},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
                  child: const Text('Sign Up', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp(GlobalKey<FormState> registrationKey) async {
    if (registrationKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Processing Data'),
            duration: Duration(
              seconds: 1,
            ),
          )
      );
    }

    String email = _emailController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("$email name", _nameController.text);
    await prefs.setString("$email password", _passwordController.text);
    await prefs.setInt("$email phoneNo", int.tryParse(_phoneNoController.text)!);
  }
}