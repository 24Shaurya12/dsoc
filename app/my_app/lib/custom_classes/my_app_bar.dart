import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool backOption;

  const MyAppBar({this.backOption = true, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: backOption,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cart_page');
          },
          icon: const Icon(Icons.shopping_cart),
        ),
        IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: const Icon(
            FontAwesomeIcons.barsStaggered,
          ),
        )
      ],
      title: Text(
        'DSOC',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
