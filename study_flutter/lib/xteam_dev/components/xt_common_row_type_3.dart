import 'package:flutter/material.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row.dart';

//  ____________________________________
// |                                    |
// | label                  accessory > |
// |____________________________________|
class XtCommonRowType3 extends StatelessWidget {
  const XtCommonRowType3({
    super.key,
    this.textLabel,
    this.accessoryView,
    this.useDefaultAccessoryView = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    this.height = 44.0,
  });

  final Widget? textLabel;
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
        if (textLabel != null)
          Expanded(
            child: textLabel!,
          ),
        const SizedBox(width: 4.0),
        if (accessoryView != null) accessoryView!,
        if (useDefaultAccessoryView)
          const Icon(
            Icons.chevron_right,
            size: 24.0,
            color: Colors.grey,
          ),
      ],
    );
  }
}
