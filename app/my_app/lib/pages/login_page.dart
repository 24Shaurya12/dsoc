import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/custom_classes/my_app_bar.dart';
import 'package:my_app/models/internet_connectivity.dart';
import 'package:my_app/models/my_user_model.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/custom_classes/my_text_field.dart';
import 'package:my_app/custom_classes/my_navigation_drawer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // colorScheme: const ColorScheme.light(error: Color.fromARGB(255, 218, 192, 163)),
    return Scaffold(
      appBar: const MyAppBar(),
      endDrawer: const MyEndDrawer(),
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      body: ListView(
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
              child: Text(
                'Welcome Back!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )),
          const Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Text(
                'Login to continue',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
          const LoginForm(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white, fontSize: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 218, 192, 163),
                                width: 3))),
                    child: GestureDetector(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 218, 192, 163),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/registration_page');
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  final loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginKey,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 50),
                  child:
                      MyTextFormField(_emailController, "Please enter email")),
              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 50),
                  child: MyTextFormField(
                    _passwordController,
                    "Please enter password",
                    obscureText: true,
                  )),
              Row(children: [
                SizedBox(
                  height: 16,
                  width: 16,
                  child: ColoredBox(
                    color: Colors.white,
                    child: Checkbox(
                        activeColor: Colors.green,
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        }),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Remember me',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  width: 100,
                ),
                const Text('Forgot password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ]),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    login(loginKey);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 218, 192, 163)),
                  child: const Text('Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 25)),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> login(GlobalKey<FormState> loginKey) async {
    String scaffoldMSgContent = '';

    if (await getConnectivity() == false) {
      scaffoldMSgContent = 'No Internet! Please connect to the Internet';
    }
    else {
      if (loginKey.currentState!.validate()) {
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text);

          scaffoldMSgContent = 'Login Successful';
          Navigator.pushNamed(context, '/home_page');
          Provider.of<MyUserInfoModel>(context, listen: false)
              .login(_emailController.text, _passwordController.text);

        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            scaffoldMSgContent = 'No user found for that email.';
          } else if (e.code == 'invalid-credential') {
            scaffoldMSgContent = "User and Password don't match";
          } else if (e.code == 'invalid-email') {
            scaffoldMSgContent = 'The email provided is invalid.';
          } else if (e.code == 'too-many-requests') {
            scaffoldMSgContent = 'Too many requests';
          }
        } catch (e) {
          scaffoldMSgContent = e.toString();
        }
      }
    }

    if (scaffoldMSgContent != '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(scaffoldMSgContent),
        duration: const Duration(
          milliseconds: 1500,
        ),
      ));
    }
  }
}
