import 'package:flutter/material.dart';

class MyItemInfo {
  final int index;
  final String barcode;
  final String productName;
  final Image image;
  final String weight;
  final int price;
  late int stock;
  late int cartQuantity;


  MyItemInfo(this.index, this.barcode, this.productName, this.image, this.weight, this.price, this.stock, this.cartQuantity);

  @override
  int get hashCode => index;

  @override
  bool operator == (Object other) {
    return other is MyItemInfo && other.index == index;
  }
}


class MyProductsListModel extends ChangeNotifier {

  final List<MyItemInfo> _myItemsInfoList = [];

  List<MyItemInfo> get myItemsInfoList => _myItemsInfoList;

  void add(MyItemInfo myItemInfo) {
    _myItemsInfoList.add(myItemInfo);
    notifyListeners();
  }

  MyItemInfo getByIndex(int index) => _myItemsInfoList[index];
}

