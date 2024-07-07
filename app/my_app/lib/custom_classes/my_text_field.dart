import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String errorMsg;
  final bool obscureText;

  const MyTextFormField(this.controller, this.errorMsg, {this.obscureText = false, super.key});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.errorMsg;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 250, 239),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(),
        ),
      ),
    );
  }
}
