import 'package:flutter/material.dart';

class NavigationTitle extends StatelessWidget {
  const NavigationTitle({
    super.key,
    this.title,
    this.titleAlign = TextAlign.left,
    this.titleStyle = const TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.bold,
    ),
    this.backButton,
    this.rightButtons = const [],
    this.borderRadius,
    this.height,
  });

  final String? title;
  final TextAlign? titleAlign;
  final TextStyle? titleStyle;

  final Widget? backButton;
  final List<Widget?> rightButtons;

  final double? height;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final padding =
        (titleAlign == TextAlign.start && backButton != null) ? 0.0 : 12.0;
    final nonNullRightButtons = rightButtons.whereType<Widget>().toList();
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      child: Row(
        children: [
          if (backButton != null) backButton!,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Text(
                title ?? '',
                style: titleStyle,
                overflow: TextOverflow.ellipsis,
                textAlign: titleAlign,
              ),
            ),
          ),
          if (nonNullRightButtons.isNotEmpty)
            ...nonNullRightButtons
          else
            (backButton != null && titleAlign == TextAlign.center
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left),
                      iconSize: 0,
                      onPressed: () {},
                    ),
                  )
                : Container()),
        ],
      ),
    );
  }
}
