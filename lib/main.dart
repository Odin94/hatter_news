import 'package:flutter/material.dart';
import 'package:hatter_news/widgets/pages/comments_page.dart';
import 'package:hatter_news/widgets/pages/posts_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hatter News',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Hatter News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum PageState { posts_page, comments_page }

class _MyHomePageState extends State<MyHomePage> {
  PageState state;
  int openPostId;

  _openCommentsPage(int openPostId) {
//    setState(() {
//      state = PageState.comments_page;
//      this.openPostId = openPostId;
//    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  // Here we take the value from the MyHomePage object that was created by
                  // the App.build method, and use it to set our appbar title.
                  title: Text(widget.title),
                ),
                body: CommentPage(
                    postId: openPostId, closePost: _goToPostsPage))));
  }

  _goToPostsPage() {
    setState(() {
      state = PageState.posts_page;
      this.openPostId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    buildPage() {
      switch (state) {
        case PageState.posts_page:
          return PostsPage(openPost: _openCommentsPage);
        case PageState.comments_page:
          return CommentPage(postId: openPostId, closePost: _goToPostsPage);
        default:
          return PostsPage(openPost: _openCommentsPage);
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: buildPage());
  }
}

class DefaultPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
    );
  }
}
