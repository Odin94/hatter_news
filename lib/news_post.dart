import 'package:flutter/material.dart';
import 'package:hatter_news/main.dart';

class NewsPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            height: 350,
            padding: EdgeInsets.all(4.0),
            color: Colors.white,
            child: Card(
                color: Colors.black87,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'images/test.png',
                        height: 160.0,
                        fit: BoxFit.cover,
                      ),
                      HeadLine(
                          text:
                              "Congress votes to make open government data the default in the United States"),
                      PostInfo(
                          author: "danso",
                          ageWithUnit: "7 hours",
                          commentCount: "81",
                          score: "544")
                    ]))));
  }
}

class HeadLine extends StatelessWidget {
  HeadLine({Key key, @required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 18))));
  }
}

class PostInfo extends StatelessWidget {
  PostInfo(
      {Key key,
      @required this.author,
      @required this.ageWithUnit,
      @required this.commentCount,
      @required this.score})
      : super(key: key);

  final String author, ageWithUnit, commentCount, score;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(children: [
          Row(children: [
            Text("by $author",
                style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text("  |  ",
                style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text("$ageWithUnit ago",
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ]),
          DefaultPadding(),
          Row(children: [
            Text("$commentCount comments",
                style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text("  |  ",
                style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text("score: $score",
                style: TextStyle(color: Colors.orange, fontSize: 12)),
          ])
        ]));
  }
}
