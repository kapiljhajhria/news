import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final bool poll;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final List descendants;

  ItemModel(
      this.id,
      this.deleted,
      this.type,
      this.by,
      this.time,
      this.text,
      this.dead,
      this.parent,
      this.poll,
      this.kids,
      this.url,
      this.score,
      this.title,
      this.descendants);

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'],
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'],
        parent = parsedJson['parent'],
        poll = parsedJson['poll'],
        kids = parsedJson['kids'],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  ItemModel.fromDb(Map<String, dynamic> mapDb)
      : id = mapDb['id'],
        deleted = mapDb['deleted'] == 1,
        type = mapDb['type'],
        by = mapDb['by'],
        time = mapDb['time'],
        text = mapDb['text'],
        dead = mapDb['dead'] == 1,
        parent = mapDb['parent'],
        poll = mapDb['poll'],
        kids = jsonDecode(mapDb['kids']),
        url = mapDb['url'],
        score = mapDb['score'],
        title = mapDb['title'],
        descendants = mapDb['descendants'];
}
