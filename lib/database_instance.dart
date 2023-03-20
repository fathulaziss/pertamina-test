// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pertamina_test/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInstance {
  final String databaseName = 'my_database.db';
  final int databaseVersion = 1;

  final String table = 'product';
  final String id = 'id';
  final String itemId = 'item_id';
  final String itemName = 'item_name';
  final String barcode = 'barcode';

  Database? database;

  Future<Database> checkDatabase() async {
    if (database != null) {
      return database!;
    } else {
      database = await initDatabase();
      return database!;
    }
  }

  Future<Database> initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, databaseName);
    return openDatabase(path, version: databaseVersion, onCreate: onCreate);
  }

  Future onCreate(Database database, int version) async {
    await database.execute(
      'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $itemId TEXT NULL, $itemName TEXT NULL, $barcode TEXT NULL)',
    );
  }

  Future<List<ProductModel>> all() async {
    database ??= await initDatabase();
    final data = await database!.query(table);
    final result = data.map((e) => ProductModel.fromJson(e)).toList();

    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    database ??= await initDatabase();
    final query = await database!.insert(table, row);
    return query;
  }

  Future<int> update(int paramId, Map<String, dynamic> row) async {
    database ??= await initDatabase();
    final query = await database!
        .update(table, row, where: '$id =?', whereArgs: [paramId]);
    return query;
  }

  Future<int> delete(int paramId) async {
    database ??= await initDatabase();
    final query =
        await database!.delete(table, where: '$id =?', whereArgs: [paramId]);
    return query;
  }
}
