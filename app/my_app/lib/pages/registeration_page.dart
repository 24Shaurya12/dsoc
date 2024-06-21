import 'package:flutter/material.dart';

void main() =>  runApp(const SignUpPage());

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sign_Up Page',
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
          body: const Center(child: SignUpColumn()),
        )
    );
  }
}



class SignUpColumn extends StatefulWidget {
  const SignUpColumn({super.key});

  @override
  State<SignUpColumn> createState() => _SignUpColumnState();
}

class _SignUpColumnState extends State<SignUpColumn> {
  final _name = TextEditingController();
  final _password = TextEditingController();

  String name = 'John';
  String password = 'Doe';

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
        Container(
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
        ElevatedButton(onPressed: (){
          setState(() {
            name = _name.text.toString();
            password = _password.text;
          });
        }, child: const Text('Sign_Up')),
        const SizedBox(height: 20,),
        Text('Username :$name Password :$password'),

      ],
    );
  }
}
