import 'package:flutter/material.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row.dart';

//  ________________________________________________________________________________
// | Column[                                      | Column[                         |
// | Row[this is a very  | additional tag | ...]] | Row[... | tag | detailLabel]] > |
// |     long text label                          |                                 |
// |     so i create                              |                                 |
// |     this component                           |                                 |
// |______________________________________________|_________________________________|
class XtCommonRowType6 extends StatelessWidget {
  const XtCommonRowType6({
    super.key,
    this.textLabel,
    this.detailTextLabel,
    this.accessoryView,
    this.useDefaultAccessoryView = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<Widget>? textLabel;
  final Widget? detailTextLabel;
  final Widget? accessoryView;

  final VoidCallback? onTap;

  final bool useDefaultAccessoryView;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return XtCommonRow(
      onTap: onTap,
      padding: padding,
      height: null,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              Row(
                children: [
                  if (textLabel != null) ...textLabel!,
                  //* Usage sample
                  // Flexible(
                  //   child: ColoredBox(
                  //     color: Colors.orange,
                  //     child: Text(
                  //       'Text A: This is a long text that can span up to two lines if necessary.',
                  //       maxLines: 3,
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //   ),
                  // ),
                  // Text(
                  //   'Text B',
                  // ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (detailTextLabel != null) detailTextLabel!,
                if (accessoryView != null)
                  Row(
                    children: [
                      const SizedBox(width: 4.0),
                      accessoryView!,
                    ],
                  ),
                if (useDefaultAccessoryView)
                  const Row(
                    children: [
                      SizedBox(width: 4.0),
                      Icon(
                        Icons.chevron_right,
                        size: 24.0,
                        color: Colors.grey,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
