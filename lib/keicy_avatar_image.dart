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
  final double fontSize;
  final double elevation;
  final int letters;
  final File image;
  final String heroTag;
  final Color backColor;

  KeicyAvatarImage({
    @required this.url,
    @required this.userName,
    this.width = 70.0,
    this.height = 70.0,
    this.borderWidth = 0.0,
    this.borderRadius,
    this.fontSize = 20.0,
    this.elevation = 0.0,
    this.letters = 2,
    this.image,
    this.heroTag,
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: Colors.white,
      shape: CircleBorder(),
      child: Hero(
        tag: heroTag ?? "avatar_profile",
        child: Padding(
          padding: EdgeInsets.all(borderWidth),
          child: (image == null)
              ? KeicyNetworkImage(
                  url: url,
                  height: width,
                  width: height,
                  borderRadius: borderRadius ?? width / 2,
                  errorWidget: Container(
                    height: width,
                    width: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius ?? width / 2),
                      color: backColor ?? Colors.grey[200],
                    ),
                    child: Center(
                      child: Text(
                        userName != "" ? userName.substring(0, letters).toUpperCase() : "U",
                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              : Container(
                  height: width,
                  width: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius ?? width / 2),
                    image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
                  ),
                ),
        ),
      ),
    );
  }
}
