import 'package:flutter/material.dart';
import 'package:my_app/classes/header.dart';
import 'package:my_app/classes/my_cart_model.dart';
import 'package:my_app/classes/my_home_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MyHeader(),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_product_page');},
              child: const Text('Add Product')
          ),
          ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/cart_page');}, child: const Text('Cart')),
          Expanded(
            child: Consumer<MyProductsListModel>(
              builder: (context, productList, child) {
                return ListView.builder(
                    itemCount: productList.myItemsInfoList.length,
                    itemBuilder: (context, index) {
                      var itemInfo = productList.getByIndex(index);
                      return MyItem(itemInfo);
                    }
                );
              }
            ),
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

    // var myItemInfo = context.select<ProductsListModel, MyItemInfo>(
    //     (homePage) => homePage.getByIndex(index),
    // );

    // String title = '';
    // String image = 'assets/products/oreo.jpg';
    // int stock = 0;
    // int stock = myItemInfo.stock;
    // String stockMsg = 'No stock';

    // print(tempStock[1]['title']);
    // print(tempStock[1]['stock']);
    // print(tempStock[1]['image']);


    // title = tempStock[index]['title'];
    // stock = tempStock[index]['stock'];
    // index<2 ? image = tempStock[index]['image'] : ();

    // print('Start');

    // print(image);

    String stockMsg = 'No stock';

    if (itemInfo.stock != 0) {
      stockMsg = 'There are ${itemInfo.stock} products in stock';
    }

    var isInCart = Provider.of<MyCartListModel>(context, listen: true).isInCart(itemInfo);

    return ListTile(
      leading: Text(itemInfo.image),
      title: Text(itemInfo.title),
      subtitle: Text('Price = ${itemInfo.price}, $stockMsg'),
      trailing: isInCart ? ChangeQuantityButton(itemInfo) : AddItemButton(itemInfo),
    );
  }
}

class AddItemButton extends StatelessWidget {
  final MyItemInfo itemInfo;

  const AddItemButton(this.itemInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: () {
          Provider.of<MyCartListModel>(context, listen: false).addToCart(itemInfo);
        },
        child: const Text('Add')
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
    var itemCartQuantity = itemInfo.cartQuantity;
    return SizedBox(
      width: 100,
      child: Consumer<MyCartListModel> (
        builder: (context, cartList, child) {
          return Row(
            children: [
              SizedBox(
                width: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(Icons.remove),
                  onPressed: () {
                    cartList.removeQuantity(itemInfo);
                  },
                ),
              ),
              Expanded(child: Center(child: Text(cartList.getQuantity(itemInfo).toString()))),
              SizedBox(
                width: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: itemStock != 0 ? () {cartList.addQuantity(itemInfo);} : null,
                  child: const Icon(Icons.add),
                ),
              ),

            ],
          );
        }
      ),
    );
  }
}
