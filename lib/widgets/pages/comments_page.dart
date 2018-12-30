import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hatter_news/hackernews/hackernews_client.dart';
import 'package:hatter_news/hackernews/item.dart';
import 'package:hatter_news/linkpreview/linkpreview.dart';
import 'package:hatter_news/widgets/components/comment.dart';
import 'package:hatter_news/widgets/components/preview_image.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key key, @required this.postId, this.closePost})
      : super(key: key);

  final int postId;
  final closePost;

  @override
  State<StatefulWidget> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildComment(context, snapshot) {
      if (snapshot.hasData) {
        return Container(
          margin: EdgeInsets.only(top: 5.0),
          child: commentFromItem(snapshot.data),
        );
      } else if (snapshot.hasError) {
        return Container(
            child: Center(
                child: Text("Failed to fetch posts: ${snapshot.error}")));
      } else {
        return Container();
      }
    }

    // TODO: Fix nothing being displayed, probably maybe because we added a column
    buildCommentPage(context, snapshot) {
      if (snapshot.hasData) {
        return Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
              FutureBuilder<String>(
                  future: LinkPreview.getPreview(snapshot.data.url),
                  builder: PreviewImage.buildPreviewImage),
              Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: ListView(
                    padding: EdgeInsets.all(8.0),
                    children: snapshot.data.kids
                        .map<Widget>((commentId) => FutureBuilder<Item>(
                            future: HackernewsClient.getItemById(
                                commentId.toString()),
                            builder: buildComment))
                        .toList(),
                  ))
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

  Widget commentFromItem(Item item) {
    return Comment(
      author: item.by,
      text: item.text,
      nestingDepth: 1,
    );
  }
}
