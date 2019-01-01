import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hatter_news/hackernews/hackernews_client.dart';
import 'package:hatter_news/hackernews/item.dart';
import 'package:hatter_news/linkpreview/linkpreview.dart';
import 'package:hatter_news/widgets/components/comment.dart';
import 'package:hatter_news/widgets/components/preview_image.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key key, @required this.postId}) : super(key: key);

  final int postId;

  @override
  State<StatefulWidget> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Function(BuildContext context, AsyncSnapshot<Item> snapshot)
        buildCommentChainWithDepth(int depth) {
      return (context, snapshot) {
        if (snapshot.hasData) {
          Item item = snapshot.data;
          List<Widget> commentChain = [
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: commentFromItem(item, depth),
            )
          ];

          if (item.kids != null) {
            for (int subCommentId in item.kids) {
              commentChain.add(FutureBuilder<Item>(
                  future: HackernewsClient.getItemById(subCommentId.toString()),
                  builder: buildCommentChainWithDepth(depth + 1)));
            }
          }

          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: commentChain);
        } else if (snapshot.hasError) {
          return Container(
              child: Center(
                  child: Text("Failed to fetch posts: ${snapshot.error}")));
        } else {
          return Padding(
            padding: EdgeInsets.all(1.0),
          );
        }
      };
    }

    Widget buildHeader(snapshot) {
      return Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 260.0,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: FutureBuilder<String>(
                        future: LinkPreview.getPreview(snapshot.data.url),
                        builder: PreviewImage.getBuildPreviewImageWithHeight(
                            160.0))),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(
                  snapshot.data.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ]));
    }

    buildComments(snapshot) {
      try {
        return snapshot.data.kids
            .map<Widget>((commentId) => FutureBuilder<Item>(
                future: HackernewsClient.getItemById(commentId.toString()),
                builder: buildCommentChainWithDepth(0)))
            .toList();
      } catch (err) {
        print("Failed to buildComments(): $err");
        return [Padding(padding: EdgeInsets.all(5.0))];
      }
    }

    // TODO: Fix nothing being displayed, probably maybe because we added a column
    buildCommentPage(context, snapshot) {
      if (snapshot.hasData) {
        return Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: ListView(
                    padding: EdgeInsets.all(8.0),
                    children: ([buildHeader(snapshot)]
                      ..addAll(buildComments(snapshot))),
                  )))
        ]));
      } else if (snapshot.hasError) {
        return Container(
            child: Center(
                child: Text("Failed to fetch posts: ${snapshot.error}")));
      } else {
        return Container(child: Center(child: CircularProgressIndicator()));
      }
    }

    return FutureBuilder<Item>(
        future: HackernewsClient.getItemById(widget.postId.toString()),
        builder: buildCommentPage);
  }

  Widget commentFromItem(Item item, int depth) {
    return Comment(
      author: item.by,
      text: item.text,
      nestingDepth: depth,
    );
  }
}
