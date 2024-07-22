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
      body: Consumer<MyCartListModel>(
        builder: (context, cartList, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: cartList.myCartItemsInfoList.length,
                    itemBuilder: (context, index) {
                      var cartItemInfo = cartList.getByIndex(index);
                      return MyItem(cartItemInfo);
                    }),
              ),
              const Divider(),
              Center(
                child: Text(
                  'Total Price: \u{20B9}${cartList.getTotalPrice}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 20, 80, 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cartList.isEmpty ? null : cartList.checkout,
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
