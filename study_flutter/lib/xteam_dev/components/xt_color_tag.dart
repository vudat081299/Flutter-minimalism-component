import 'package:flutter/material.dart';

class XtColorTag extends StatelessWidget {
  const XtColorTag({
    super.key,
    required this.child,
    this.color = Colors.orange,
    this.onPressed,
  });

  final Widget? child;
  final Color? color;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        splashColor: color,
        highlightColor: color?.withAlpha(0),
        borderRadius: BorderRadius.circular(4),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: child,
        ),
      ),
    );
  }
}
