import 'package:flutter/material.dart';
import 'package:my_app/classes/my_home_model.dart';
import 'package:provider/provider.dart';

class MyCartListModel extends ChangeNotifier {

  // late MyProductsListModel _home;

  final List<MyItemInfo> _myCartItemsInfoList = [];

  // MyProductsListModel get home => _home;

  // set home(MyProductsListModel newHome) {
  //   _home = newHome;
  //   notifyListeners();
  // }

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
    print("Item added");
    print(myItemInfo.index);
    print(myItemInfo.productName);
    getLength();
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
    print("Item removed");
    print(myItemInfo.index);
    print(myItemInfo.productName);
    getLength();
    notifyListeners();
  }

  void getLength() {
    print(_myCartItemsInfoList.length);
  }

  MyItemInfo getByIndex(int index) => _myCartItemsInfoList[index];

  int get totalPrice => myCartItemsInfoList.fold(0, (total, current) => total + current.price);
}