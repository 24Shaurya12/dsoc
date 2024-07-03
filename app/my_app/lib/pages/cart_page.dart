import 'package:flutter/material.dart';
import 'package:my_app/classes/header.dart';
import 'package:my_app/classes/my_cart_model.dart';
import 'package:provider/provider.dart';
import 'package:my_app/pages/home_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MyHeader(),
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
