class Item {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final DateTime time;
  final bool dead;
  final int descendants;
  final String title;
  final String url;
  final String text;
  final int score;
  final int parent;
  final int poll;
  final List<dynamic> parts;
  final List<dynamic> kids;
  List<Item> comments = List();

  Item(
      {this.id,
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
      this.parts,
      this.descendants});

  factory Item.fromJson(Map<String, dynamic> json) {
    if (json['error'] != null) {
      print(json['error']);
      throw Exception(json['error']);
    }

    DateTime dateTime;
    if (json['time'] != null) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(json['time']);
    }

    return Item(
        id: json['id'],
        deleted: _boolOrNull(json['deleted']),
        type: json['type'],
        by: json['by'],
        time: dateTime,
        text: json['text'],
        dead: _boolOrNull(json['dead']),
        parent: json['parent'],
        poll: json['poll'],
        kids: json['kids'],
        url: json['url'],
        score: json['score'],
        title: json['title'],
        parts: json['parts'],
        descendants: json['descendants']);
  }
}

_boolOrNull(String str) {
  if (str == null) return null;

  if (str.toLowerCase() == "true") return true;
  return false;
}
