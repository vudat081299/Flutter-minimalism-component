import 'package:flutter/material.dart';

//  ______________________________________________________
// |                                                      |
// | Row[                                                 |
// | Column[image] | Column[Addess, this address is very  |
// |               |        long so we..]]                |
// |______________________________________________________|
class DoingDeliveryPointActionRow extends StatelessWidget {
  const DoingDeliveryPointActionRow({
    super.key,
    this.leftSide,
    this.rightSide,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
  });

  final Widget? leftSide;
  final Widget? rightSide;
  final EdgeInsetsGeometry padding;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leftSide != null) leftSide!,
            if (leftSide != null) const SizedBox(width: 4),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      if (rightSide != null)
                        Flexible(
                          child: rightSide!,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
