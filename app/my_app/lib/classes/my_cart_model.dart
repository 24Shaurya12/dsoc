import 'package:flutter/material.dart';
import 'package:my_app/classes/my_home_model.dart';

class MyCartListModel extends ChangeNotifier {

  // late MyProductsListModel _home;

  final List<MyItemInfo> _cartMyItemsInfoList = [];

  // MyProductsListModel get home => _home;

  // set home(MyProductsListModel newHome) {
  //   _home = newHome;
  //   notifyListeners();
  // }

  List<MyItemInfo> get myCartItemsInfoList => _cartMyItemsInfoList;

  bool isInCart(MyItemInfo myItemInfo) {
    return _cartMyItemsInfoList.contains(myItemInfo);
  }

  int getQuantity(MyItemInfo myItemInfo) {
    return _cartMyItemsInfoList[myItemInfo.index].cartQuantity;
  }

  void addToCart(MyItemInfo myItemInfo) {
    _cartMyItemsInfoList.contains(myItemInfo) ? () : _cartMyItemsInfoList.add(myItemInfo);
    addQuantity(myItemInfo);
    notifyListeners();
  }

  void addQuantity(MyItemInfo myItemInfo) {
    _cartMyItemsInfoList[myItemInfo.index].cartQuantity++;
    _cartMyItemsInfoList[myItemInfo.index].stock--;
    notifyListeners();
  }

  void removeQuantity(MyItemInfo myItemInfo) {
    _cartMyItemsInfoList[myItemInfo.index].cartQuantity--;
    _cartMyItemsInfoList[myItemInfo.index].stock++;
    if(_cartMyItemsInfoList[myItemInfo.index].cartQuantity == 0) {
      removeFromCart(myItemInfo);
    }
    notifyListeners();
  }

  void removeFromCart(MyItemInfo myItemInfo) {
    _cartMyItemsInfoList.remove(myItemInfo);
    notifyListeners();
  }

  MyItemInfo getByIndex(int index) => _cartMyItemsInfoList[index];

  int get totalPrice => myCartItemsInfoList.fold(0, (total, current) => total + current.price);
}