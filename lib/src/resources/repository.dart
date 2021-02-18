import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  //init db

  //fetch top Ids from api
  Future<List<int>> fetchTopIds() => sources[1].fetchTopIds();

  //fetch item, check local db first, if null fetch from api

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    // Source source;
    for (var source in sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }
    if (item == null) {
      print("fetchItem called for id $id and returned null");
      return null;
    }
    for (var cache in caches) {
      // if(cache!=source){
      // cache.addItem(item);
      // }
      cache.addItem(item);
    }
    return item;
  }

  Future<void> clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
