import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/custom_classes/my_app_bar.dart';
import 'package:my_app/custom_classes/my_text_field.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:my_app/custom_classes/my_navigation_drawer.dart';

import '../models/my_user_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        endDrawer: const MyEndDrawer(),
        backgroundColor: const Color.fromARGB(255, 16, 44, 87),
        body: ListView(
          children: const [
            Center(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    'Create Account Now!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            RegistrationForm(),
          ],
        ));
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
                  child:
                      MyTextFormField(_nameController, "Please enter a name")),
              const Text('Email'),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
                  child:
                      MyTextFormField(_emailController, "Please enter email")),
              const Text('Password'),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
                  child: MyTextFormField(
                    _passwordController,
                    "Please enter password",
                    obscureText: true,
                  )),
              const Text('Phone No'),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
                  child: MyTextFormField(
                      _phoneNoController, "Please enter phone number")),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    signUp(registrationKey);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 218, 192, 163)),
                  child: const Text('Sign Up',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp(GlobalKey<FormState> registrationKey) async {
    String scaffoldMSgContent = '';
    if (registrationKey.currentState!.validate()) {
      try {
        final UserCredential credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text
          );

        scaffoldMSgContent = 'Account Created';
        Navigator.pushNamed(context, '/home_page');

        Provider.of<MyUserInfoModel>(context, listen: false).signUp(
            _nameController.text,
            _emailController.text,
            // _passwordController.text,
            int.parse(_phoneNoController.text));

        await credentials.user?.updateDisplayName(_nameController.text);


      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          scaffoldMSgContent = 'The password provided is too weak.';
        }
        else if (e.code == 'email-already-in-use') {
          scaffoldMSgContent = 'The account already exists for that email.';
        }
        else if(e.code == 'invalid-email') {
          scaffoldMSgContent = 'The email provided is invalid.';
        }
      } catch (e) {
        scaffoldMSgContent = e.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(scaffoldMSgContent),
        duration: const Duration(
          milliseconds: 1500,
        ),
      ));
    }
  }
}
