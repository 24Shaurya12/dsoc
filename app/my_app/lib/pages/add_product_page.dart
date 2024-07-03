import 'package:flutter/material.dart';
import 'package:my_app/classes/header.dart';
import 'package:my_app/classes/my_home_model.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      body: ListView(
        children: const [
          MyHeader(),
          Center(
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
          AddProductForm(),
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
  final _imageController = TextEditingController();
  final _stockController = TextEditingController();

  final addProductKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addProductKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const Text('Image'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              child: TextFormField(
                controller: _imageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
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
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (addProductKey.currentState!.validate()) {

                    final newItemInfo = MyItemInfo(
                      Provider.of<MyProductsListModel>(context, listen: false).myItemsInfoList.length,
                      _titleController.text,
                      _imageController.text,
                      int.parse(_priceController.text),
                      int.parse(_stockController.text),
                      0,
                    );

                    _titleController.clear();
                    _priceController.clear();
                    _imageController.clear();
                    _stockController.clear();

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
}