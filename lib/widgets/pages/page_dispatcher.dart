import 'package:flutter/material.dart';
import 'package:hatter_news/widgets/pages/comments_page.dart';
import 'package:hatter_news/widgets/pages/posts_page.dart';

enum PageState { posts_page, comments_page }

class PageDispatcher extends StatelessWidget {
  PageDispatcher(
      {Key key,
      @required this.state,
      @required this.title,
      this.openCommentsPage,
      this.openPostId})
      : super(key: key);

  final PageState state;
  final String title;
  final Function openCommentsPage;
  final int openPostId;

  @override
  Widget build(BuildContext context) {
    buildPage() {
      switch (state) {
        case PageState.posts_page:
          return PostsPage(openPost: openCommentsPage);
        case PageState.comments_page:
          return CommentsPage(postId: openPostId);
        default:
          return PostsPage(openPost: openCommentsPage);
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
        ),
        body: buildPage());
  }
}
