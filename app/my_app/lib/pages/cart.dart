import 'package:flutter/material.dart';
import 'package:my_app/classes/my_cart_model.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
              child: CartList(),
          )
        ],
      ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCartModel>(
      builder: (context, cart, child) {
        return ListView.builder(
          itemCount: cart.myCartItems.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              cart.myCartItems[index].title,
            )
          ),
        );
      }
    );
  }
}
