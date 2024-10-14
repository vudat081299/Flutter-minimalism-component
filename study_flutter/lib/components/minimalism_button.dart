import 'package:flutter/material.dart';

class MinimalismButton extends StatelessWidget {
  const MinimalismButton({
    super.key,
    required this.text,
    required this.action,
  });

  final String text;
  final Function action;

  @override
  Widget build(BuildContext context) {
    // bool isBright = Theme.of(context).brightness == Brightness.light;
    // final textColor = isBright ? Colors.white : Colors.black;
    // final backgroundColor = isBright ? Colors.black : Colors.white;
    return TextButton(
      onPressed: () {
        action();
      },
      style: TextButton.styleFrom(
          // backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      child: Text(text),
    );
  }
}
