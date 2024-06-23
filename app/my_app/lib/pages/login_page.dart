import 'package:flutter/material.dart';

void main() =>  runApp(const LoginPage());

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login Page',
        theme: ThemeData(
            primaryColor: Colors.green,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue,
            )
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Sample Text'),
          ),
          body: const Center(child: LoginColumn()),
        )
    );
  }
}



class LoginColumn extends StatefulWidget {
  const LoginColumn({super.key});

  @override
  State<LoginColumn> createState() => _LoginColumnState();
}

class _LoginColumnState extends State<LoginColumn> {
  final _name = TextEditingController();
  final _password = TextEditingController();

  String name = 'John';
  String password = 'Doe';

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            controller: _name,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          width: 200,
          child: TextField(
            controller: _password,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),

                )
            ),
          ),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: () {
            setState() {
              name = _name.text.toString();
              password = _password.text;
            }
          },
          child: const Text('Login')
        ),
        const SizedBox(height: 20,),
        Text('Username :$name Password :$password'),

      ],
    );
  }
}
