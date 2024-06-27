import 'package:flutter/material.dart';
import 'package:my_app/my_app_bar.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login Page',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(error: Color.fromARGB(255, 218, 192, 163)),
        ),
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 16, 44, 87),
          body: ListView(
            children: [
              const MyAppBar(),
              const Padding(
                padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
                child: Text('Welcome Back!',  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
              const Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Text('Login to continue',textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)),
              const LoginForm(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(width: 10,),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color.fromARGB(255, 218, 192, 163), width: 3))
                        ),
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
                ),)
            ],
          ),

        )
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
              const Text('Email',textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white,),),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 50),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
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
              const Text('Password', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white,),),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 50),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
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
              Row(
              children: [
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
                      }
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                const Text('Remember me', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
                const SizedBox(width: 100,),
                const Text('Forgot password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
              ]
                              ),
              const SizedBox(height: 40,),
              SizedBox(
               width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: (){login(loginKey);},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
                  child: const Text('Login', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 25)),
                ),
              ),
          ],
        )
      ),
    );
  }

  Future<void> login(GlobalKey<FormState> loginKey) async {
    loginKey.currentState!.validate();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(prefs.getString("email"));
    // print(_emailController.text);
    // print(prefs.getString("password"));
    // print(_passwordController.text);

    String email = _emailController.text;

    if (prefs.getString("$email password") == _passwordController.text && _passwordController.text != '') {
      const snackBar = SnackBar(
        content: Text('Login Successful'),
        duration: Duration(
            seconds: 1), // Optional duration to display the SnackBar
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // break;
    }
    else {
      const snackBar = SnackBar(
        content: Text('Try Again'),
        duration: Duration(
            seconds: 2), // Optional duration to display the SnackBar
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  // }
  }
}
