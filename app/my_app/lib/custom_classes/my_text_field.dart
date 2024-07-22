import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String errorMsg;
  final bool requiredField;
  final bool passwordField;

  const MyTextFormField(this.controller, this.errorMsg,
      {this.requiredField = false, this.passwordField = false, super.key});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool passwordObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.passwordField ? passwordObscure : false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.errorMsg;
        }
        return null;
      },
      decoration: InputDecoration(
        helperText: widget.requiredField ? '*required' : null,
        helperStyle: const TextStyle(
          color: Color.fromARGB(255, 218, 192, 102),
        ),
        suffixIcon: widget.passwordField
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    passwordObscure = !passwordObscure;
                  });
                },
                child: Icon(
                  passwordObscure ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
    );
  }
}
