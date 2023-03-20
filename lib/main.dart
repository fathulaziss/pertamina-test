// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:pertamina_test/models/product_model.dart';
import 'package:pertamina_test/pages/home_page.dart';
import 'package:pertamina_test/pages/item_page.dart';
import 'package:pertamina_test/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        ItemPage.routeName: (context) => ItemPage(
              data: ModalRoute.of(context)?.settings.arguments != null
                  ? ModalRoute.of(context)?.settings.arguments as ProductModel
                  : null,
            ),
        SearchPage.routeName: (context) => const SearchPage(),
      },
    );
  }
}
