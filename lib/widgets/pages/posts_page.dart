import 'package:flutter/material.dart';
import 'package:hatter_news/hackernews/hackernews_client.dart';
import 'package:hatter_news/hackernews/item.dart';
import 'package:hatter_news/main.dart';
import 'package:hatter_news/widgets/components/news_post.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  Future<List<Item>> posts;

  @override
  void initState() {
    super.initState();
    posts = HackernewsClient.getItemsByType("topstories", 16);
  }

  @override
  Widget build(BuildContext context) {
    buildPostList(context, snapshot) {
      if (snapshot.hasData) {
        return Container(
          margin: EdgeInsets.only(top: 20.0),
          child: postsFromItems(snapshot.data),
        );
      } else if (snapshot.hasError) {
        return Center(child: Text("Failed to fetch posts: ${snapshot.error}"));
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body:
            FutureBuilder<List<Item>>(future: this.posts, builder: buildPostList));
  }

  Widget postsFromItems(List<Item> data) {
    List<Widget> rows = new List();

    for (int i = 0; i < data.length; i += 2) {
      if (i + 1 < data.length) {
        rows.add(Row(children: [
          NewsPost(data[i]),
          DefaultPadding(),
          NewsPost(data[i + 1])
        ]));
      } else {
        rows.add(Row(children: [
          NewsPost(data[i]),
        ]));
      }
    }

    return ListView(padding: EdgeInsets.all(8.0), children: rows);
  }
}
