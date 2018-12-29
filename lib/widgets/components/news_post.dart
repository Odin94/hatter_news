import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:hatter_news/hackernews/item.dart';
import 'package:hatter_news/linkpreview/linkpreview.dart';
import 'package:hatter_news/main.dart';

class NewsPost extends StatelessWidget {
  final Item item;
  final openPost;

  NewsPost({Key key, this.item, this.openPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildPreviewImage(context, snapshot) {
      if (snapshot.hasData) {
        return Image.network(
          snapshot.data,
          height: 160.0,
          fit: BoxFit.cover,
        );
      } else {
        return Image.asset(
          "images/defaultPreview.png",
          height: 160.0,
          fit: BoxFit.cover,
        );
      }
    }

    return Expanded(
        child: GestureDetector(
            onTap: () {
              openPost(this.item.id);
            },
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
                          FutureBuilder<String>(
                              future: LinkPreview.getPreview(this.item.url),
                              builder: buildPreviewImage),
                          HeadLine(text: item.title),
                          Expanded(
                            child: PostInfo(
                                author: item.by,
                                ageWithUnit: "7 hours",
                                commentCount: item.descendants,
                                score: item.score),
                          ),
                        ])))));
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
