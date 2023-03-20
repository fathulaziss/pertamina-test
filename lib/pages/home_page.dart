import 'package:flutter/material.dart';
import 'package:pertamina_test/pages/item_page.dart';
import 'package:pertamina_test/pages/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pertamina Test')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ItemPage.routeName);
              },
              child: const Text('Item'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              child: const Text('Search Item'),
            ),
          ],
        ),
      ),
    );
  }
}
