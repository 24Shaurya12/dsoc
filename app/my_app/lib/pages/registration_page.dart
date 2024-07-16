import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/custom_classes/my_app_bar.dart';
import 'package:my_app/custom_classes/my_text_field.dart';
import 'package:my_app/models/internet_connectivity.dart';
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
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text(
                'Create Account Now!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          const RegistrationForm(),
        ],
      ),
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  helperText: '*required',
                  helperStyle: TextStyle(
                    color: Color.fromARGB(255, 218, 192, 102),
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
            ),
            Text(
              'Email',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: MyTextFormField(
                _emailController,
                "Please enter email",
              ),
            ),
            Text(
              'Password',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye),
                ),
              ),
            ),
            Text(
              'Phone No',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: MyTextFormField(
                _phoneNoController,
                "Please enter phone number",
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  signUp(registrationKey);
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp(GlobalKey<FormState> registrationKey) async {
    String scaffoldMSgContent = '';

    if (await getConnectivity() == false) {
      scaffoldMSgContent = "No Internet! Please connect to the Internet";
    } else {
      if (registrationKey.currentState!.validate()) {
        try {
          final UserCredential credentials = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text);

          scaffoldMSgContent = 'Account Created';
          Navigator.pushNamed(context, '/home_page');

          Provider.of<MyUserInfoModel>(context, listen: false).signUp(
              _nameController.text,
              _emailController.text,
              int.parse(_phoneNoController.text));
          await credentials.user?.updateDisplayName(_nameController.text);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            scaffoldMSgContent = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            scaffoldMSgContent = 'The account already exists for that email.';
          } else if (e.code == 'invalid-email') {
            scaffoldMSgContent = 'The email provided is invalid.';
          }
        } catch (e) {
          scaffoldMSgContent = e.toString();
        }
      }
    }

    if (scaffoldMSgContent != '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(scaffoldMSgContent),
          duration: const Duration(
            milliseconds: 1500,
          ),
        ),
      );
    }
  }
}
