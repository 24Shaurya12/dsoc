import 'package:flutter/material.dart';
import 'package:my_app/custom_classes/my_app_bar.dart';
import 'package:my_app/models/my_cart_model.dart';
import 'package:my_app/models/my_home_model.dart';
import 'package:my_app/variables/variables.dart';
import 'package:provider/provider.dart';
import 'package:my_app/custom_classes/my_navigation_drawer.dart';
import 'add_to_cart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        backOption: false,
      ),
      endDrawer: const MyEndDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 30, 60, 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_product_page');
              },
              child: const Text(
                'Add New Product',
              ),
            ),
          ),
          Expanded(
            child: Consumer<MyProductsListModel>(
              builder: (context, productList, child) {
                return ListView.builder(
                  itemCount: productList.myItemsInfoList.length,
                  itemBuilder: (context, index) {
                    var itemInfo = productList.getByIndex(index);
                    return MyItem(itemInfo);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addProduct(context);
          for (var item in Provider.of<MyCartListModel>(context, listen: false)
              .myCartItemsInfoList) {
            print('Name: ${item.productName}, barcode: ${item.barcode}');
          }
          Navigator.pushNamed(context, '/cart_page');
        },
        backgroundColor: dsocYellow,
        foregroundColor: Colors.black,
        child: const Icon(
          Icons.barcode_reader,
        ),
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
      leading: SizedBox(
          width: 40,
          child: itemInfo.image ?? Image.asset('assets/no_image.jpg')),
      title: Text(
        itemInfo.productName,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(
        'Price = ${itemInfo.price}, $stockMsg',
        style: Theme.of(context).textTheme.labelSmall,
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
        onPressed: itemInfo.stock > 0
            ? () {
                Provider.of<MyCartListModel>(context, listen: false)
                    .addToCart(itemInfo);
              }
            : null,
        child: const Text(
          'Add',
        ),
      ),
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
      width: 110,
      child: Consumer<MyCartListModel>(builder: (context, cartList, child) {
        return Row(
          children: [
            SizedBox(
              width: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: const Icon(
                  Icons.remove,
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
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: itemStock != 0
                    ? () {
                        cartList.addQuantity(itemInfo);
                        print(itemInfo.cartQuantity);
                      }
                    : null,
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
