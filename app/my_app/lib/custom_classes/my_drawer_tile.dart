import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final IconData iconData;
  final String msg;
  final String? route;
  final Function? inputFunction;

  const MyDrawerTile(this.iconData, this.msg, this.route,
      {this.inputFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ListTile(
        leading: Icon(
          iconData,
          size: 30,
          color: Colors.white,
        ),
        title: Text(
          msg,
          style: Theme.of(context).textTheme.labelMedium,
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
