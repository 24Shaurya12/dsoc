import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/classes/header.dart';
import 'package:my_app/classes/my_home_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      body: ListView(
        children: [
          const MyHeader(),
          const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text(
                'Add Product',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          const AddProductForm(),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 10, 60, 0),
            child: ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/home_page');}, child: const Text('Go Back to Products Page')))
        ],
      ),
    );
  }
}

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _weightController = TextEditingController();

  String result = "no";
  Product? product;

  final addProductKey = GlobalKey<FormState>();

  File? imageFileLocation; //add default image and make this non nullable
  Image image = const Image(image: AssetImage("assets/no_image.jpg"));

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addProductKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Barcode'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {

                        SharedPreferences itemInfoSharePreferences = await SharedPreferences.getInstance();

                        itemInfoSharePreferences.setString("barcode", "");
                        itemInfoSharePreferences.setString("weight", "");
                        itemInfoSharePreferences.setString("productName", "");
                        itemInfoSharePreferences.setString("imageURL", "");
                        image = const Image(image: AssetImage("assets/no_image.jpg"));

                        String? barcodeResult = await barcodeScanner();
                        if (barcodeResult != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please wait while we fetch data'),
                              duration: Duration(
                                milliseconds: 2500,
                              ),
                            )
                          );

                          await getProductInfo(barcodeResult);

                          if (itemInfoSharePreferences.getString('productName') == "") {
                            print("Ye Dekh");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sorry, no data found'),
                                duration: Duration(
                                  milliseconds: 2500,
                                ),
                              )
                            );
                          }
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Barcode couldn't be scanned"),
                                duration: Duration(
                                  milliseconds: 1500,
                                ),
                              )
                          );
                        }

                        print("Start ${itemInfoSharePreferences.getString("barcode")}, ${itemInfoSharePreferences.getString("imageURL")},");
                        setState(() {
                          _barcodeController.text = itemInfoSharePreferences.getString("barcode") ?? "";
                          _weightController.text = itemInfoSharePreferences.getString("weight") ?? "";
                          _titleController.text = itemInfoSharePreferences.getString('productName') ?? "";
                          if (itemInfoSharePreferences.getString("imageURL") != null && itemInfoSharePreferences.getString("imageURL") != "") {
                            image = Image.network(itemInfoSharePreferences.getString("imageURL")!);
                          }
                        });
                        print("End ${_barcodeController.text}, ");
                      },
                      child: const Text("Scan Barcode")
                  ),
                  const Expanded(
                      child: SizedBox(
                        child: Center(
                            child: Text('Or')
                        ),
                      )
                  ),
                  SizedBox(
                    width: 180,
                    child: TextFormField(
                      controller: _barcodeController,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if ((value == null || value.isEmpty) && product?.barcode == null) {
                          return 'Please enter barcode';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Enter Manually',
                        hintStyle: const TextStyle(fontSize: 15),
                        fillColor: const Color.fromARGB(255, 255, 250, 239),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text('Product Name'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 250, 239),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            ),
            const Text('Price'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: TextFormField(
                controller: _priceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 250, 239),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            ),
            const Text('Stock'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: TextFormField(
                controller: _stockController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 250, 239),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(),
                    )
                ),
              ),
            ),
            const Text('Weight'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: TextFormField(
                controller: _weightController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 250, 239),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(),
                    )
                ),
              ),
            ),
            const Text('Image'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: Row(
                children: [
                  const SizedBox(width: 40,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 250, 239)),
                    onPressed: () {
                      pickImage();
                    },
                    child: const Text('Pick Image', style: TextStyle(fontSize: 18, color: Colors.black),),
                  ),
                  const Expanded(child: SizedBox()),
                  // if (image == null) const Text('Image Preview') else
                  SizedBox(width: 80, child: image),
                  const SizedBox(width: 70,),
                ]
              )
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (addProductKey.currentState!.validate()) {
                    final newItemInfo = MyItemInfo(
                      Provider.of<MyProductsListModel>(context, listen: false).myItemsInfoList.length,
                      _barcodeController.text,
                      _titleController.text,
                      image,
                      _weightController.text,
                      int.parse(_priceController.text),
                      int.parse(_stockController.text),
                      0,
                    );

                    _titleController.clear();
                    _priceController.clear();
                    _stockController.clear();
                    imageFileLocation = null;

                    Provider.of<MyProductsListModel>(context, listen: false).add(newItemInfo);

                    Navigator.pushNamed(context, '/home_page');
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
                child: const Text('Add Product', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 25)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    var cameraPermission = await Permission.camera.request();
    if (cameraPermission.isGranted) {
      final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if(returnedImage == null)
        return;
      else {
        setState(() {
          imageFileLocation = File(returnedImage.path);
          image = Image.file(imageFileLocation!);
        });
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Camera Permission not granted'),
            duration: Duration(
              milliseconds: 1000,
            ),
          )
      );
    }
  }


  Future<String?> barcodeScanner() async {
    var cameraPermission = await Permission.camera.request();
    if (cameraPermission.isGranted) {
      var barcodeResult = await FlutterBarcodeScanner.scanBarcode("#00FF00", "Cancel", false, ScanMode.DEFAULT);

      if (barcodeResult[0] == '8') {
        SharedPreferences itemInfoSharedPreferences = await SharedPreferences.getInstance();
        await itemInfoSharedPreferences.setString("barcode", barcodeResult);
        return barcodeResult;
      }
      else {
        return null;
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera Permission not granted'),
          duration: Duration(
            milliseconds: 1000,
          ),
        )
      );
    }

    return null;
  }


  Future<void> getProductInfo(String barcode) async {
    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'DSoC2024');
    OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[OpenFoodFactsLanguage.ENGLISH];

    final ProductQueryConfiguration myItemBarcode = ProductQueryConfiguration(barcode, version: ProductQueryVersion.v3);
    final ProductResultV3 myItemInfoOpenFood = await OpenFoodAPIClient.getProductV3(myItemBarcode);

    var product = myItemInfoOpenFood.product;


    if (product != null) {
      SharedPreferences itemInfoSharedPreferences = await SharedPreferences.getInstance();
      await itemInfoSharedPreferences.setString("productName", product.productName ?? "");
      await itemInfoSharedPreferences.setString("weight", product.quantity ?? "");
      await itemInfoSharedPreferences.setString("imageURL", product.imageFrontSmallUrl.toString() ?? "");
    }
  }
}