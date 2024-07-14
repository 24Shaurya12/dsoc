import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/custom_classes/my_drawer_tile.dart';
import 'package:my_app/models/my_user_model.dart';
import 'package:provider/provider.dart';

class MyEndDrawer extends StatelessWidget {
  const MyEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 32, 55, 100),
      child: ListView(
        padding: const EdgeInsets.only(top: 70),
        children: [
          const MyDrawerTile(Icon(Icons.list, size: 30, color: Colors.white,), 'Products Catalog', '/home_page'),
          const MyDrawerTile(Icon(Icons.add, size: 30, color: Colors.white,), 'Add New Product', '/add_product_page'),
          const MyDrawerTile(Icon(Icons.shopping_cart_checkout, size: 30, color: Colors.white,), 'Go to Cart', '/cart_page'),
          const Divider(),
          const MyDrawerTile(Icon(FontAwesomeIcons.userAstronaut, size: 27, color: Colors.white,), 'Profile', '/profile_page'),
          MyDrawerTile(const Icon(Icons.logout, size: 30, color: Colors.white,), 'Logout', '/welcome_page', inputFunction: Provider.of<MyUserInfoModel>(context, listen: false).logout,),],
      )
    );
  }
}
