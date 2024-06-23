import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      toolbarHeight: 150,
      title: const Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: Center(child: Text('DSOC', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)))),
          SizedBox(width: 100),
          Expanded(child: Icon(Icons.menu, color: Colors.white, size: 40)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
