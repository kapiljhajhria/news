import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  // Observable<Map<int,Future<ItemModel>>> items;
  // Stream<Map<int, Future<ItemModel>>> items; //no longer needed

  //getters to streams

  //getter to get stream/ rxdart = observable -depreciated
  Stream<List<int>> get topIds =>
      _topIds.stream; //stream with no data right now

  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // get items => _items.stream.transform(_itemsTransformer());

  //getter to sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    // items = _items.stream.transform(_itemsTransformer());

    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids =
        await _repository.fetchTopIds(); //repository makes api call and fetches
    //the list of integers
    //after getting the list of integers, we use sink and add the data to the stream
    _topIds.sink.add(ids);
  }

  clearCache() {
    return _repository.clearCache();
  }

  _itemsTransformer() {
    print("itemTrasformer called");
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        // print("index $index");
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _itemsOutput.close();
    _itemsFetcher.close();
    _topIds.close();
    // _items.close();
  }
}
