import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final Icon icon;
  final String msg;
  final String? route;
  final Function? inputFunction;

  const MyDrawerTile(this.icon, this.msg, this.route, {this.inputFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ListTile(
        leading: icon,
        title: Text(
          msg,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        onTap: () {
          if (inputFunction != null) {
            inputFunction!();
          }
          Navigator.pushNamed(context, route!);
        },
      ),
    );
  }
}
