import 'package:flutter/material.dart';
import 'package:my_app/custom_classes/my_app_bar.dart';
import 'package:my_app/models/my_cart_model.dart';
import 'package:provider/provider.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/custom_classes/my_navigation_drawer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      endDrawer: const MyEndDrawer(),
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MyCartListModel>(
              builder: (context, cartList, child) {
                return ListView.builder(
                  itemCount: cartList.myCartItemsInfoList.length,
                  itemBuilder: (context, index) {
                    var cartItemInfo = cartList.getByIndex(index);
                    return MyItem(cartItemInfo);
                  }
                );
              }
            )
          )
        ],
      ),
    );
  }
}
