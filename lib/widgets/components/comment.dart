import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class Comment extends StatelessWidget {
  Comment(
      {Key key,
      @required this.author,
      @required this.text,
      @required this.nestingDepth})
      : super(key: key);

  final String author, text;
  final int nestingDepth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0 * this.nestingDepth),
        color: Colors.white70,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(author,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.deepOrange, fontSize: 14))),
          Padding(
              padding: EdgeInsets.only(
                  left: 6.0,
                  top: 6.0,
                  right: 6.0,
                  bottom: 6.0),
              child: HtmlView(data: "<p>$text</p>")),  // workaround: paragraph wrap to make HtmlView render free-flowing text

//              Text(text,
//                  style: TextStyle(color: Colors.black38, fontSize: 14)))
        ]));
  }
}
