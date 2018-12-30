import 'dart:ui';

import 'package:flutter/material.dart';

class PreviewImage {
  static Widget _getDefaultPreviewImage() {
    return Image.asset(
      "images/defaultPreview.png",
      height: 160.0,
      fit: BoxFit.cover,
    );
  }

  static Widget buildPreviewImage(
      BuildContext context, AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
      try {
        return Image.network(
          snapshot.data,
          height: 160.0,
          fit: BoxFit.cover,
        );
      } catch (err) {
        print(
            "Failed to load image from ${snapshot.data} in new_post. Error: $err");
        return _getDefaultPreviewImage();
      }
    } else {
      return _getDefaultPreviewImage();
    }
  }
}
