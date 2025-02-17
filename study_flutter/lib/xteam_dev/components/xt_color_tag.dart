import 'package:flutter/material.dart';

class XtColorTag extends StatelessWidget {
  const XtColorTag({
    super.key,
    required this.child,
    this.color = Colors.orange,
    this.borderRadius = 4,
    this.padding = const EdgeInsets.all(4),
    this.onPressed,
  });

  final Widget? child;
  final Color? color;
  final double borderRadius;
  final EdgeInsets padding;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        splashColor: color,
        highlightColor: color?.withAlpha(0),
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onPressed,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
