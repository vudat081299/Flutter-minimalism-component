import 'package:flutter/material.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row.dart';

//  ____________________________________
// |                                    |
// | label                detailLabel > |
// |____________________________________|
class XtCommonRowType1 extends StatelessWidget {
  const XtCommonRowType1({
    super.key,
    this.textLabel,
    this.detailTextLabel,
    this.accessoryView,
    this.useDefaultAccessoryView = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    this.height = 44.0,
  });

  final Widget? textLabel;
  final Widget? detailTextLabel;
  final Widget? accessoryView;

  final VoidCallback? onTap;

  final bool useDefaultAccessoryView;
  final EdgeInsetsGeometry padding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return XtCommonRow(
      onTap: onTap,
      padding: padding,
      height: height,
      children: [
        if (textLabel != null) textLabel!,
        const Spacer(),
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
    );
  }
}
