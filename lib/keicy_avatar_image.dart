library keicy_avatar_image;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keicy_network_image/keicy_network_image.dart';

class KeicyAvatarImage extends StatelessWidget {
  final String url;
  final String userName;
  final double width;
  final double height;
  final double borderWidth;
  final double borderRadius;
  final TextStyle textStyle;
  final double fontSize;
  final Color textColor;
  final double elevation;
  final int letters;
  final File image;
  final String heroTag;
  final Color backColor;
  final Color borderColor;

  KeicyAvatarImage({
    @required this.url,
    @required this.userName,
    this.width = 70.0,
    this.height = 70.0,
    this.borderWidth = 0.0,
    this.borderRadius,
    this.elevation = 0.0,
    this.letters = 2,
    this.image,
    this.heroTag,
    this.backColor,
    this.fontSize = 20.0,
    this.textColor = Colors.black,
    this.textStyle,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = Padding(
      padding: EdgeInsets.all(borderWidth),
      child: (image == null)
          ? KeicyNetworkImage(
              url: url,
              width: width,
              height: height,
              borderRadius: borderRadius ?? width / 2,
              borderColor: Colors.transparent,
              borderWidth: 0,
              errorWidget: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius ?? width / 2),
                  color: backColor ?? Colors.grey[200],
                ),
                child: Center(
                  child: Text(
                    userName != "" ? userName.substring(0, letters).toUpperCase() : "U",
                    style: textStyle ?? TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor),
                  ),
                ),
              ),
            )
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius ?? width / 2),
                image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
              ),
            ),
    );
    return Material(
      elevation: elevation,
      color: borderColor,
      shape: CircleBorder(),
      child: heroTag == null
          ? widget
          : Hero(
              tag: heroTag,
              child: widget,
            ),
    );
  }
}
