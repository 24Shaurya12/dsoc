import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/my_home_model.dart';

class MyCartListModel extends ChangeNotifier {
  final List<MyItemInfo> _myCartItemsInfoList = [];
  final firestoreDB = FirebaseFirestore.instance;

  List<MyItemInfo> get myCartItemsInfoList => _myCartItemsInfoList;

  int get getTotalPrice => _myCartItemsInfoList.fold(
      0, (value, element) => value + element.price * element.cartQuantity);

  bool get isEmpty => _myCartItemsInfoList.isEmpty;

  MyItemInfo getByIndex(int index) => _myCartItemsInfoList[index];

  bool isInCart(MyItemInfo myItemInfo) {
    return _myCartItemsInfoList.contains(myItemInfo);
  }

  int getQuantity(MyItemInfo myItemInfo) {
    return myItemInfo.cartQuantity;
  }

  void addToCart(MyItemInfo myItemInfo) {
    _myCartItemsInfoList.contains(myItemInfo)
        ? ()
        : _myCartItemsInfoList.add(myItemInfo);
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
    if (myItemInfo.cartQuantity == 0) {
      removeFromCart(myItemInfo);
    }
    notifyListeners();
  }

  void removeFromCart(MyItemInfo myItemInfo) {
    _myCartItemsInfoList.remove(myItemInfo);
    notifyListeners();
  }

  checkout() async {
    for (var myItemInfo in _myCartItemsInfoList) {
      myItemInfo.cartQuantity = 0;
      var firestoreQuery = await firestoreDB
          .collection('Products')
          .where('barcode', isEqualTo: myItemInfo.barcode)
          .get();
      firestoreDB.collection('Products').doc(firestoreQuery.docs[0].id).update(
        {'stock': myItemInfo.stock},
      );
    }
    _myCartItemsInfoList.clear();

    notifyListeners();
  }
}
