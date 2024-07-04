import 'package:flutter/material.dart';
import 'package:my_app/classes/header.dart';
import 'package:my_app/classes/my_text_field.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      body: ListView(
        children: const [
          MyHeader(),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text('Create Account Now!', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
          ),
          RegistrationForm(),
        ],
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
          fontSize: 20,
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
              child: MyTextFormField(_nameController, "Please enter a name")
            ),
            const Text('Email'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: MyTextFormField(_emailController, "Please enter email")
            ),
            const Text('Password'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: MyTextFormField(_passwordController, "Please enter password")
            ),
            const Text('Phone No'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: MyTextFormField(_phoneNoController, "Please enter phone number")
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  signUp(registrationKey);
                },
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
            content: Text('Account Created'),
            duration: Duration(
              milliseconds: 1500,
            ),
          )
      );
      Navigator.pushNamed(context, '/home_page');
    }

    String email = _emailController.text;

    SharedPreferences userInfo = await SharedPreferences.getInstance();
    await userInfo.setString("$email name", _nameController.text);
    await userInfo.setString("$email password", _passwordController.text);
    await userInfo.setInt("$email phoneNo", int.tryParse(_phoneNoController.text)!);
  }
}