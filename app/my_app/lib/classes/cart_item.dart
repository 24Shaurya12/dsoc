import 'package:flutter/material.dart';
import 'package:my_app/temp_stock.dart';

class CartItem extends StatelessWidget {
  final int index;

  const CartItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    var title = tempStock[index]['title'];
    var image = index < 2 ? tempStock[index]['image'] : 'assets/products/oreo.jpg';

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Row(
        children: [
          SizedBox(
              width: 70,
              child: Image(image: AssetImage(image))),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 20),),
                // Text(quantity),
              ],
            ),
          ),
          const SizedBox(width: 20,),
          EditQuantityButton(title),
        ],
      ),
    );

  }
}

class EditQuantityButton extends StatelessWidget {
  final String title;
  const EditQuantityButton(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

