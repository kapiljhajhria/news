import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>(onListen: () {});
  final _repository = Respository();
  //getter to get stream/ rxdart = observable -depreciated
  get topIds => _topIds.stream; //stream with no data right now

  dispose() {
    _topIds.close();
  }

  fetchTopIds() async {
    final ids =
        await _repository.fetchTopIds(); //repository makes api call and fetches
    //the list of integers
    //after getting the list of integers, we use sink and add the data to the stream
    _topIds.sink.add(ids);
  }
}
