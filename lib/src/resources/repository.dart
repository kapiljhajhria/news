import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Respository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  //init db

  //fetch top Ids from api
  fetchTopIds() => apiProvider.fetchTopIds();

  //fetch item, check local db first, if null fetch from api

  fetchItem(int id) async {
    var item;

    item = dbProvider.fetchItem(id);
    //if found in db return it
    if (item != null) return item;
    //call api to fetch item
    item = await apiProvider.fetchItem(id);

    //store it to db for future use
    dbProvider.addItem(item);

    //return the item
    return item;
  }
}
