import 'package:flutter/material.dart';

class MyItemInfo {
  final int index;
  final String title;
  final String image;
  final int price;
  final int stock;

  MyItemInfo(this.index, this.title, this.image, this.price, this.stock);

  @override
  int get hashCode => index;

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is MyItemInfo && other.index == index;
  }
}


class ProductsListModel extends ChangeNotifier {

  // late ProductsListModel _home;
  // final List<int> _itemIndexes = [];

  final List<MyItemInfo> _myItemsInfoList = [];

  List<MyItemInfo> get myItemsInfoList => _myItemsInfoList;

  void add(MyItemInfo myItemInfo) {
    _myItemsInfoList.add(myItemInfo);
    notifyListeners();
  }

  MyItemInfo getByIndex(int index) => _myItemsInfoList[index];
}

