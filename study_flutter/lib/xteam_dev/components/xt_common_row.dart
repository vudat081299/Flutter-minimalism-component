import 'package:flutter/material.dart';

class XtCommonRow extends StatelessWidget {
  const XtCommonRow({
    super.key,
    required this.children,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    this.height = 44.0,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<Widget> children;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double? height;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      padding: padding,
      height: height,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            ...children,
          ],
        ),
      ),
    );
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: box,
      );
    }
    return box;
  }
}
