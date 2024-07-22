import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyItemInfo {
  final String barcode;
  final String productName;
  final Image? image;
  final File? imageFile;
  final String weight;
  final int price;
  late int stock;
  late int cartQuantity;

  MyItemInfo(this.barcode, this.productName, this.weight, this.price,
      this.stock, this.cartQuantity,
      {this.image, this.imageFile});

  // to use in firebase, have to convert this class to a map first
  Map<String, dynamic> uploadToFirestore(String firebaseImageUrl) {
    return {
      'barcode': barcode,
      'productName': productName,
      'imageUrl': firebaseImageUrl,
      'weight': weight,
      'price': price,
      'stock': stock,
    };
  }

  factory MyItemInfo.getFromFirestore(
    DocumentSnapshot<Map<String, dynamic>> firestoreDoc,
  ) {
    final firestoreData = firestoreDoc.data();
    return MyItemInfo(
      firestoreData?['barcode'],
      firestoreData?['productName'],
      firestoreData?['weight'],
      firestoreData?['price'],
      firestoreData?['stock'],
      0,
      image: firestoreData?['imageUrl'] != null
          ? Image.network(firestoreData?['imageUrl'])
          : Image.asset('assets/no_image.jpg'),
    );
  }


  @override
  int get hashCode => int.parse(barcode);

  @override
  bool operator ==(Object other) {
    return other is MyItemInfo && other.barcode == barcode;
  }
}

class MyProductsListModel extends ChangeNotifier {
  final List<MyItemInfo> _myItemsInfoList = [];
  final firestoreDB = FirebaseFirestore.instance;
  final productsStorageRef = FirebaseStorage.instance.ref().child('Products');

  MyProductsListModel() {
    firestoreDB.collection('Products').snapshots().listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            var myItemInfo = MyItemInfo.getFromFirestore(change.doc);
            _myItemsInfoList.contains(myItemInfo)
                ? ()
                : _myItemsInfoList.add(myItemInfo);
            break;
          case DocumentChangeType.modified:
          var myItemInfo = MyItemInfo.getFromFirestore(change.doc);
          _myItemsInfoList.singleWhere((item) => item.barcode == myItemInfo.barcode).stock = myItemInfo.stock;
          case DocumentChangeType.removed:
          // TODO: Handle this case.
        }

        notifyListeners();
      }
    });
  }

  List<MyItemInfo> get myItemsInfoList => _myItemsInfoList;

  Future<void> localAdd(MyItemInfo myItemInfo) async {
    await productsStorageRef
        .child(myItemInfo.barcode)
        .putFile(myItemInfo.imageFile ?? File('assets/no_image.jpg'));

    String firebaseImageUrl;
    try {
      firebaseImageUrl =
          await productsStorageRef.child(myItemInfo.barcode).getDownloadURL();
    } catch (e) {
      firebaseImageUrl = '';
    }

    await firestoreDB
        .collection('Products')
        .add(myItemInfo.uploadToFirestore(firebaseImageUrl));
  }

  MyItemInfo getByIndex(int index) => _myItemsInfoList[index];
}
