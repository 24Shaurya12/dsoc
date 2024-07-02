import 'package:flutter/material.dart';
import 'package:my_app/classes/my_home_model.dart';
import 'package:provider/provider.dart';

class MyCartModel extends ChangeNotifier {

  late ProductsListModel _home;

  final List<int> _cartItemIndexes = [];

  ProductsListModel get home => _home;

  set home(ProductsListModel newHome) {
    _home = newHome;
    notifyListeners();
  }

  List<MyItemInfo> get myCartItems => _cartItemIndexes.map((index) => _home.getByIndex(index)).toList();

  int get totalPrice => myCartItems.fold(0, (total, current) => total + current.price);

  void add(MyItemInfo myItem) {
    _cartItemIndexes.add(myItem.index);
    notifyListeners();
  }

  void remove(MyItemInfo myItem) {
    _cartItemIndexes.remove(myItem.index);
    notifyListeners();
  }
}