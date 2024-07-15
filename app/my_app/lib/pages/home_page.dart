import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/custom_classes/my_app_bar.dart';
import 'package:my_app/models/my_cart_model.dart';
import 'package:my_app/models/my_home_model.dart';
import 'package:provider/provider.dart';
import 'package:my_app/custom_classes/my_navigation_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      appBar: const MyAppBar(
        backOption: false,
      ),
      endDrawer: const MyEndDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 40, 60, 0),
            child: Row(children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/add_product_page');
                  },
                  child: const Text(
                    'Add Product',
                    style: TextStyle(color: Colors.black),
                  )),
              const Expanded(
                child: SizedBox(),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 218, 192, 163)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart_page');
                  },
                  child: const Text(
                    'Cart',
                    style: TextStyle(color: Colors.black),
                  )),
            ]),
          ),
          Expanded(
            child: Consumer<MyProductsListModel>(
                builder: (context, productList, child) {
              return ListView.builder(
                  itemCount: productList.myItemsInfoList.length,
                  itemBuilder: (context, index) {
                    var itemInfo = productList.getByIndex(index);
                    return MyItem(itemInfo);
                  });
            }),
          ),
        ],
      ),
    );
  }
}

class MyItem extends StatelessWidget {
  final MyItemInfo itemInfo;

  const MyItem(this.itemInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    String stockMsg = 'No stock';

    if (itemInfo.stock != 0) {
      stockMsg = 'There are ${itemInfo.stock} products in stock';
    }

    var isInCart =
        Provider.of<MyCartListModel>(context, listen: true).isInCart(itemInfo);

    return ListTile(
      leading: SizedBox(width: 40, child: itemInfo.image),
      title: Text(
        itemInfo.productName,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Price = ${itemInfo.price}, $stockMsg',
        style: const TextStyle(color: Colors.white),
      ),
      trailing:
          isInCart ? ChangeQuantityButton(itemInfo) : AddItemButton(itemInfo),
    );
  }
}

class AddItemButton extends StatelessWidget {
  final MyItemInfo itemInfo;

  const AddItemButton(this.itemInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
          onPressed: () {
            Provider.of<MyCartListModel>(context, listen: false)
                .addToCart(itemInfo);
          },
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.black),
          )),
    );
  }
}

class ChangeQuantityButton extends StatelessWidget {
  final MyItemInfo itemInfo;

  const ChangeQuantityButton(this.itemInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    var itemStock = itemInfo.stock;
    return SizedBox(
      width: 100,
      child: Consumer<MyCartListModel>(builder: (context, cartList, child) {
        return Row(
          children: [
            SizedBox(
              width: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
                child: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                onPressed: () {
                  cartList.removeQuantity(itemInfo);
                },
              ),
            ),
            Expanded(
                child: Center(
                    child: Text(
              cartList.getQuantity(itemInfo).toString(),
              style: const TextStyle(color: Colors.white),
            ))),
            SizedBox(
              width: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
                onPressed: itemStock != 0
                    ? () {
                        cartList.addQuantity(itemInfo);
                      }
                    : null,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
