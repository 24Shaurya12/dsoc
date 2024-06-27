import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      title: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Center(child: Text('DSOC', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white)))),
          SizedBox(width: 200),
          Expanded(child: Icon(FontAwesomeIcons.barsStaggered, color: Colors.white, size: 25)),
        ],
      ),
    );
  }
}
