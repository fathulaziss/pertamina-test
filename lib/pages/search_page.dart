import 'package:flutter/material.dart';
import 'package:pertamina_test/database_instance.dart';
import 'package:pertamina_test/models/product_model.dart';
import 'package:pertamina_test/pages/item_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  static const routeName = 'search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  final searchController = TextEditingController();
  List<ProductModel> allData = [];
  List<ProductModel> searchData = [];

  Future<void> getData() async {
    allData = await databaseInstance.all();
    setState(() {});
  }

  void filterSearch(String value) {
    final temp = <ProductModel>[];

    for (final data in allData) {
      if (data.itemId.toLowerCase().contains(value.toLowerCase()) ||
          data.itemName.toLowerCase().contains(value.toLowerCase()) ||
          data.barcode.toLowerCase().contains(value.toLowerCase())) {
        temp.add(data);
      }
    }

    searchData = temp;
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance.checkDatabase();
    getData();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: FutureBuilder<List<ProductModel>>(
        future: databaseInstance.all(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.isNotEmpty) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Text('Search'),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(),
                            ),
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {});
                                }
                              },
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                border: InputBorder.none,
                                prefixIconConstraints:
                                    BoxConstraints(minHeight: 20, minWidth: 20),
                                suffixIconConstraints:
                                    BoxConstraints(minHeight: 20, minWidth: 20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () {
                            if (searchController.text.isNotEmpty) {
                              filterSearch(searchController.text);
                            }
                          },
                          child: const Text('Find'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text('No', textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text('ItemID', textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text('ItemName', textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text('Barcode', textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: searchController.text.isNotEmpty
                        ? ListView.builder(
                            itemCount: searchData.length,
                            itemBuilder: (context, index) {
                              return itemDataSearch(context, index);
                            },
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return itemData(context, snapshot, index);
                            },
                          ),
                  )
                ],
              );
            } else {
              return const Center(child: Text('Data Kosong'));
            }
          }
        },
      ),
    );
  }

  Widget itemDataSearch(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ItemPage.routeName,
          arguments: searchData[index],
        ).then((value) {
          getData();
          searchController.clear();
          setState(() {});
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${searchData[index].id}',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                searchData[index].itemId,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                searchData[index].itemName,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                searchData[index].barcode,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemData(
    BuildContext context,
    AsyncSnapshot<List<ProductModel>> snapshot,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ItemPage.routeName,
          arguments: snapshot.data![index],
        ).then((value) => getData());
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${snapshot.data![index].id}',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                snapshot.data![index].itemId,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                snapshot.data![index].itemName,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                snapshot.data![index].barcode,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
