import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_app/custom_classes/my_app_bar.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:my_app/custom_classes/my_navigation_drawer.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({super.key});

  @override
  State<BarcodePage> createState() {
    return BarcodePageStatus();
  }
}

class BarcodePageStatus extends State<BarcodePage> {
  String result = "no";
  Product? product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      endDrawer: const MyEndDrawer(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                String barcodeResult = await barcodeScanner();
                Product? productResult = await getProductInfo(barcodeResult);
                print(productResult?.productName);
                setState(() {
                  result = barcodeResult;
                  product = productResult;
                });
                },
              child: const Text("Barcode")
          ),
          Text('Barcode is $result', style: const TextStyle(color: Colors.black),),
          Text(
            "Barcode : ${product?.barcode}, Product Name : ${product?.productName}, Weight : ${product?.quantity}, Image : ${product?.imageFrontUrl}, ${product?.imageFrontSmallUrl}",
            style: const TextStyle(color: Colors.black),
          ),
          Image.network(product?.imageFrontSmallUrl ?? 'assets/products/corn_flakes.jpg'),
        ],
      ),
    );
  }

  Future<String> barcodeScanner() async {
    print("Start");
    var cameraPermission = await Permission.camera.request();
    print(cameraPermission);
    var barcodeResult = await FlutterBarcodeScanner.scanBarcode("#00FF00", "Cancel", false, ScanMode.DEFAULT);
    print('end');
    print('result is $barcodeResult');
    return barcodeResult;
    // print((Colors.green.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0'));
    // (Colors.green.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')
  }

  Future<Product?> getProductInfo(String barcode) async {
    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'DSoC2024');
    OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[OpenFoodFactsLanguage.ENGLISH];
    OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.INDIA;

    print(barcode);

    final ProductQueryConfiguration itemDetails = ProductQueryConfiguration('7622201431594', version: ProductQueryVersion.v3);
    final ProductResultV3 result = await OpenFoodAPIClient.getProductV3(itemDetails);

    final String pt = result.product?.productName ?? 'nothing';

    print(pt);

    return result.product;
  }
}


