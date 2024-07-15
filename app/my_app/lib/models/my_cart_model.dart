import 'package:flutter/material.dart';
import 'package:my_app/models/my_home_model.dart';

class MyCartListModel extends ChangeNotifier {

  final List<MyItemInfo> _myCartItemsInfoList = [];

  List<MyItemInfo> get myCartItemsInfoList => _myCartItemsInfoList;

  bool isInCart(MyItemInfo myItemInfo) {
    return _myCartItemsInfoList.contains(myItemInfo);
  }

  int getQuantity(MyItemInfo myItemInfo) {
    return myItemInfo.cartQuantity;
  }

  void addToCart(MyItemInfo myItemInfo) {
    _myCartItemsInfoList.contains(myItemInfo) ? () : _myCartItemsInfoList.add(myItemInfo);
    addQuantity(myItemInfo);
    notifyListeners();
  }

  void addQuantity(MyItemInfo myItemInfo) {
    myItemInfo.cartQuantity++;
    myItemInfo.stock--;
    notifyListeners();
  }

  void removeQuantity(MyItemInfo myItemInfo) {
    myItemInfo.cartQuantity--;
    myItemInfo.stock++;
    if(myItemInfo.cartQuantity == 0) {
      removeFromCart(myItemInfo);
    }
    notifyListeners();
  }

  void removeFromCart(MyItemInfo myItemInfo) {
    _myCartItemsInfoList.remove(myItemInfo);
    getLength();
    notifyListeners();
  }

  void getLength() {
  }

  MyItemInfo getByIndex(int index) => _myCartItemsInfoList[index];

  int get totalPrice => myCartItemsInfoList.fold(0, (total, current) => total + current.price);
}