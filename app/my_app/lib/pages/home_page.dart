import 'package:flutter/material.dart';
import 'package:my_app/classes/header.dart';
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
                Navigator.pushNamed(context, '/add_product');},
              child: const Text('Add Product')
          ),
          Expanded(
            child: Consumer<ProductsListModel>(
              builder: (context, myProductList, child) {
                return ListView.builder(
                    itemCount: myProductList.myItemsInfoList.length,
                    itemBuilder: (context, index) {
                      var itemInfo = myProductList.getByIndex(index);
                      return MyItemLayout(itemInfo);
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

class MyItemLayout extends StatelessWidget {
  final MyItemInfo itemInfo;

  const MyItemLayout(this.itemInfo, {super.key});

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

    return ListTile(
      leading: Text(itemInfo.image),
      title: Text(itemInfo.title),
      subtitle: Text('Price = ${itemInfo.price}, $stockMsg'),
    );
  }
}

class AddItemButton extends StatelessWidget {
  final int index;

  const AddItemButton(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: const Text('Add')
    );
  }
}
