import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:hatter_news/hackernews/item.dart';
import 'package:hatter_news/main.dart';

class NewsPost extends StatelessWidget {
  final Item item;

  NewsPost(this.item);

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
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'images/test.png',
                        height: 160.0,
                        fit: BoxFit.cover,
                      ),
                      HeadLine(text: item.title),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PostInfo(
                                author: item.by,
                                ageWithUnit: "7 hours",
                                commentCount: item.descendants,
                                score: item.score),
                          ]),
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
            child: AutoSizeText(text,
                maxLines: 5,
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

  final String author, ageWithUnit;
  final int commentCount, score;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                AutoSizeText("by $author",
                    maxLines: 1,
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ]),
              DefaultPadding(),
//              Row(children: [
//                AutoSizeText("$ageWithUnit ago",
//                    maxLines: 1,
//                    style: TextStyle(color: Colors.white70, fontSize: 12)),
//              ]),
//              DefaultPadding(),
              Row(children: [
                AutoSizeText("$commentCount comments",
                    maxLines: 1,
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                Text("  |  ",
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                AutoSizeText("score: $score",
                    maxLines: 1,
                    style: TextStyle(color: Colors.orange, fontSize: 12)),
              ])
            ]));
  }
}
