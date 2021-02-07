import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>(onListen: () {});
  final _items = BehaviorSubject<int>();
  final _repository = Respository();

  // Observable<Map<int,Future<ItemModel>>> items;
  Stream<Map<int, Future<ItemModel>>> items;
  //getter to get stream/ rxdart = observable -depreciated
  get topIds => _topIds.stream; //stream with no data right now

  // get items => _items.stream.transform(_itemsTransformer());

  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }

  fetchTopIds() async {
    final ids =
        await _repository.fetchTopIds(); //repository makes api call and fetches
    //the list of integers
    //after getting the list of integers, we use sink and add the data to the stream
    _topIds.sink.add(ids);
  }

  Function(int) get fetchItem => _items.sink.add;

  _itemsTransformer() {
    print("itemTrasformer called");
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, index) {
      print("index $index");
      cache[id] = _repository.fetchItem(id);
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}
