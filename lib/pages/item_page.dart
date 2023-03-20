// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pertamina_test/database_instance.dart';
import 'package:pertamina_test/models/product_model.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key, this.data}) : super(key: key);

  final ProductModel? data;

  static const routeName = 'item';

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  final itemIdController = TextEditingController();
  final itemNameController = TextEditingController();
  final barcodeController = TextEditingController();

  @override
  void initState() {
    databaseInstance.checkDatabase();
    if (widget.data != null) {
      itemIdController.text = widget.data!.itemId;
      itemNameController.text = widget.data!.itemName;
      barcodeController.text = widget.data!.barcode;
    }
    super.initState();
  }

  @override
  void dispose() {
    itemIdController.dispose();
    itemNameController.dispose();
    barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(flex: 2, child: Text('ItemID')),
                  Expanded(
                    flex: 6,
                    child: TextField(controller: itemIdController),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(flex: 2, child: Text('ItemName')),
                  Expanded(
                    flex: 6,
                    child: TextField(controller: itemNameController),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(flex: 2, child: Text('Barcode')),
                  Expanded(
                    flex: 6,
                    child: TextField(controller: barcodeController),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      if (itemIdController.text.isNotEmpty &&
                          itemNameController.text.isNotEmpty &&
                          barcodeController.text.isNotEmpty) {
                        await databaseInstance.insert({
                          'item_id': itemIdController.text,
                          'item_name': itemNameController.text,
                          'barcode': barcodeController.text,
                        });

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Semua Field Harus Diisi'),
                          ),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      if (widget.data != null) {
                        await databaseInstance.update(
                          widget.data!.id,
                          {
                            'item_id': itemIdController.text,
                            'item_name': itemNameController.text,
                            'barcode': barcodeController.text,
                          },
                        );

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data Tidak Tersedia Di Database'),
                          ),
                        );
                      }
                    },
                    child: const Text('Edit'),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      if (widget.data != null) {
                        await databaseInstance.delete(widget.data!.id);

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data Tidak Tersedia Di Database'),
                          ),
                        );
                      }
                    },
                    child: const Text('Delete'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
