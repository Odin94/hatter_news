import 'package:flutter/material.dart';

class NewsPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            color: Colors.white,
            height: 300,
            padding: EdgeInsets.all(4.0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(2.0),
                  bottomRight: Radius.circular(2.0),
                )),
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
                      Text("Test")
                    ]))));
  }
}
