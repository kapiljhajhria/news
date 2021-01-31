import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  Database db;

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, "items.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute(""" 
      CREATE TABLE Items
      (
        id INTEGER PRIMARY KEY
        type TEXT,
        by TEXT,
        time INTEGER,
        text TEXT,
        parent INTEGER,
        kids BLOB,
        dead INTEGER,
        deleted INTEGER,
        url TEXT,
        score INTEGER,
        descendants INTEGER
      )
       """);
    });
  }

  fetchItem(int id) async {
    //get item from database

    //query the item

    final maps = await db.query("Items",
        distinct: true, columns: null, where: "id=?", whereArgs: [id]);

    if (maps.length > 0) {
      return ItemModel.fromDb(maps[0]);
    }
    return null;
  }

  addItem(ItemModel item) => db.insert("Items", item.toMapForDb());
}
