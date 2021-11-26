library keicy_avatar_image;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class KeicyAvatarImage extends StatefulWidget {
  KeicyAvatarImage({
    Key? key,
    @required this.url,
    this.shimmerEnable = false,
    this.width,
    this.height,
    this.userName,
    this.textStyle,
    this.fit = BoxFit.cover,
    this.borderWidth = 0.0,
    this.borderRadius = 0,
    this.elevation = 0.0,
    this.letters = 2,
    this.imageFile,
    this.heroTag,
    this.backColor,
    this.borderColor = Colors.transparent,
    this.shimmerLoading = true,
    this.baseColor,
    this.highlightColor,
    this.errorColor,
    this.loadingWidget,
    this.errorWidget,
    this.color,
    this.colorBlendMode,
  }) : super(key: key);

  final String? url;
  final bool? shimmerEnable;
  final double? width;
  final double? height;
  final String? userName;
  final TextStyle? textStyle;
  final BoxFit? fit;
  final double? borderWidth;
  final double? borderRadius;
  final double? elevation;
  final int? letters;
  final File? imageFile;
  final String? heroTag;
  final Color? backColor;
  final Color? borderColor;
  final bool? shimmerLoading;
  final Color? baseColor;
  final Color? highlightColor;
  Widget? loadingWidget;
  Widget? errorWidget;
  final Color? errorColor;
  final Color? color;
  final BlendMode? colorBlendMode;
  double? indicatorSize;

  @override
  _KeicyAvatarImageState createState() => _KeicyAvatarImageState();
}

class _KeicyAvatarImageState extends State<KeicyAvatarImage> {
  Widget? image;
  Widget? shimmerWidget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.indicatorSize != null) {
      widget.indicatorSize = widget.indicatorSize ??
          ((widget.height != null)
              ? widget.height! / 5
              : (widget.width != null)
                  ? widget.width! / 5
                  : 20);
    }

    shimmerWidget = Shimmer.fromColors(
      child: Container(
        width: widget.width ?? widget.height,
        height: widget.height ?? widget.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(widget.borderRadius!), color: Colors.white),
      ),
      baseColor: widget.baseColor ?? Colors.grey[300]!,
      highlightColor: widget.highlightColor ?? Colors.grey[100]!,
      direction: ShimmerDirection.ltr,
      period: const Duration(milliseconds: 1000),
    );

    widget.loadingWidget = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backColor,
        borderRadius: BorderRadius.circular(widget.borderRadius!),
      ),
      child: widget.shimmerLoading!
          ? shimmerWidget
          : Center(
              child: (widget.loadingWidget ?? const CupertinoActivityIndicator()),
            ),
    );

    widget.errorWidget = widget.userName == null
        ? Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backColor,
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: Center(
              child: widget.errorWidget ?? Icon(Icons.not_interested, size: widget.indicatorSize, color: widget.errorColor),
            ),
          )
        : Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backColor,
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: Center(
              child: Text(widget.userName == "" ? "" : widget.userName!.substring(0, 2), style: widget.textStyle),
            ),
          );

    image = (widget.imageFile != null)
        ? Image.file(
            widget.imageFile!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            color: widget.color,
            colorBlendMode: widget.colorBlendMode,
            filterQuality: FilterQuality.low,
            errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
              return widget.errorWidget!;
            },
          )
        : (widget.url != null && widget.url != "")
            ?
            //
            // widget.errorWidget
            Image.network(
                widget.url!,
                width: widget.width,
                height: widget.height,
                fit: widget.fit,
                // color: widget.color,
                // colorBlendMode: widget.colorBlendMode,
                filterQuality: FilterQuality.low,
                loadingBuilder: (BuildContext? context, Widget? child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child!;
                  }
                  return widget.loadingWidget!;
                },
                errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                  return widget.errorWidget!;
                },
              )
            : widget.errorWidget;

    Widget imageWidget = Padding(
      padding: EdgeInsets.all(widget.borderWidth!),
      child: widget.shimmerEnable!
          ? shimmerWidget
          : (widget.imageFile != null || (widget.url != "" && widget.url != null))
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                  child: image,
                )
              : widget.errorWidget,
    );

    return Material(
      elevation: widget.elevation!,
      color: widget.borderColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius!),
      ),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
        child: widget.heroTag == null
            ? imageWidget
            : Hero(
                tag: widget.heroTag!,
                child: imageWidget,
              ),
      ),
    );
  }
}
