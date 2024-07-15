import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyItemInfo {
  final String barcode;
  final String productName;
  final Image image;
  final String weight;
  final int price;
  late int stock;
  late int cartQuantity;

  MyItemInfo(this.barcode, this.productName, this.image,
      this.weight, this.price, this.stock, this.cartQuantity);

  // to use in firebase, have to convert this class to a map first
  Map<String, dynamic> toFirestore() {
    return {
      'barcode': barcode,
      'productName': productName,
      'weight': weight,
      'price': price,
      'stock': stock,
    };
  }

  factory MyItemInfo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> firestoreDoc,
  ) {
    final firestoreData = firestoreDoc.data();
    return MyItemInfo(
        firestoreData?['barcode'],
        firestoreData?['productName'],
        const Image(image: AssetImage("assets/no_image.jpg")),
        firestoreData?['weight'],
        firestoreData?['price'],
        firestoreData?['stock'],
        0);
  }

  @override
  int get hashCode => int.parse(barcode);

  @override
  bool operator ==(Object other) {
    return other is MyItemInfo && other.barcode == barcode;
  }
}

class MyProductsListModel extends ChangeNotifier {
  FirebaseFirestore firestoreDB = FirebaseFirestore.instance;
  final List<MyItemInfo> _myItemsInfoList = [];

  MyProductsListModel() {
    firestoreDB.collection('Products').snapshots().listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            var myItemInfo = MyItemInfo.fromFirestore(change.doc);
            _myItemsInfoList.add(myItemInfo);
            break;
          case DocumentChangeType.modified:
            // TODO: Handle this case.
          case DocumentChangeType.removed:
            // TODO: Handle this case.
        }

        notifyListeners();
      }
    });
  }

  List<MyItemInfo> get myItemsInfoList => _myItemsInfoList;

  void localAdd(MyItemInfo myItemInfo) {
    _myItemsInfoList.add(myItemInfo);
    notifyListeners();
    firestoreDB.collection('Products').add(myItemInfo.toFirestore()).then(
        (DocumentReference currentDoc) =>
            print('Document added, ID: ${currentDoc.id}'));
  }

  MyItemInfo getByIndex(int index) => _myItemsInfoList[index];

}
