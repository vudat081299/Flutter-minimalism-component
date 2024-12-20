import 'package:flutter/material.dart';

class XtTagModel {
  XtTagModel({
    required this.tag,
    this.color = Colors.green,
    this.onPressed
  });

  final String tag;
  final Color color;
  final VoidCallback? onPressed;
}
