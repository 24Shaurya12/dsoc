import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/variables/variables.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:my_app/models/my_home_model.dart';
import 'package:provider/provider.dart';

import '../models/my_cart_model.dart';

final firestoreDB = FirebaseFirestore.instance;

addProduct(BuildContext context) async {
  var barcode = await barcodeScanner();
  String? productName = 'No barcode Scanned';
  MyItemInfo? itemInfo;
  if (barcode != '-1' && barcode != null) {
    itemInfo = await checkBarcodeExists(barcode, context);
    productName = itemInfo?.productName ?? 'No product found';
    if (itemInfo != null) {
      Provider.of<MyCartListModel>(context, listen: false).addToCart(itemInfo);
    }
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: dsocBlue,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Product: $productName',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  itemInfo != null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Quantity in Cart: ',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              ChangeQuantityButton(itemInfo!),
                            ],
                          ),
                        )
                      : const SizedBox(
                          width: 5,
                          height: 5,
                        ),
                  Row(
                    children: [
                      Text(
                        'Barcode: ',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            hintText: 'Enter Barcode Manually',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                          onSubmitted: (String barcode) async {
                            var itemInfoTemp =
                                await checkBarcodeExists(barcode, context);
                            setState(() {
                              if (itemInfoTemp != null) {
                                itemInfo = itemInfoTemp;
                                for (var item in Provider.of<MyCartListModel>(
                                        context,
                                        listen: false)
                                    .myCartItemsInfoList) {
                                  print(
                                      'Name: ${item.productName}, CartQuant: ${item.cartQuantity}');
                                }
                                Provider.of<MyCartListModel>(context,
                                        listen: false)
                                    .addToCart(itemInfo!);
                                for (var item in Provider.of<MyCartListModel>(
                                        context,
                                        listen: false)
                                    .myCartItemsInfoList) {
                                  print(
                                      'Name: ${item.productName}, CartQuant: ${item.cartQuantity}');
                                }
                              }
                              productName = itemInfoTemp?.productName;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  itemInfo != null
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  // Navigator.pop(context);
                                  // addProduct(context);
                                  barcode = await barcodeScanner();
                                  if (barcode != '-1' && barcode != null) {
                                    print('if waale me');
                                    var itemInfoTemp = await checkBarcodeExists(
                                        barcode!, context);
                                    setState(() {
                                      if (itemInfoTemp != null) {
                                        itemInfo = itemInfoTemp;
                                        Provider.of<MyCartListModel>(context,
                                                listen: false)
                                            .addToCart(itemInfo!);
                                      }
                                      productName = itemInfoTemp?.productName ??
                                          'No product found';
                                    });
                                  } else {
                                    print('else waale me');
                                    setState(
                                      () {
                                        itemInfo = null;
                                        productName = 'No Barcode Scanned';
                                      },
                                    );
                                  }
                                },
                                child: const Text('Add Another Product'),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/cart_page');
                                },
                                child: const Text('Done'),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<MyItemInfo?> checkBarcodeExists(
    String barcode, BuildContext context) async {
  final queryResult = await firestoreDB
      .collection('Products')
      .where('barcode', isEqualTo: barcode)
      .get();
  if (queryResult.docs.isEmpty) {
    return null;
  }
  return Provider.of<MyProductsListModel>(context, listen: false)
      .getByBarcode(barcode);
}

Future<String?> barcodeScanner() async {
  var cameraPermission = await Permission.camera.request();
  if (cameraPermission.isGranted) {
    var barcodeResult = await FlutterBarcodeScanner.scanBarcode(
      "#00FF00",
      "Cancel",
      false,
      ScanMode.DEFAULT,
    );
    return barcodeResult;
  }
  return null;
}
