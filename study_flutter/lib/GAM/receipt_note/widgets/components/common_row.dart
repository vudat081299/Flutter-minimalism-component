import 'package:flutter/material.dart';

class CommonRow extends StatelessWidget {
  const CommonRow({
    super.key,
    required this.children,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    this.height = 44.0,
    this.isDynamicHeight = false,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<Widget> children;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double? height;
  final bool isDynamicHeight;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      padding: padding,
      height: isDynamicHeight ? null : height,
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
