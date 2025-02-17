import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_flutter/xteam_dev/components/order_action_bar.dart';
import 'package:study_flutter/xteam_dev/components/string_extension.dart';
import 'package:study_flutter/xteam_dev/components/xt_color_tag.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row_type_6.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_model.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_row.dart';

class XtNextOrder extends StatefulWidget {
  const XtNextOrder({
    super.key,
    this.selectAction,
    this.isSubStation = false,
  });

  final VoidCallback? selectAction;
  final bool isSubStation;

  @override
  State<XtNextOrder> createState() => _XtNextOrderState();
}

class _XtNextOrderState extends State<XtNextOrder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    //* Prepare data
    final String? stationName = 'BC Miếu Đầm (HN)';
    final String? computedCoordinateDistanceText = '3,3 km';
    final List<XtTagModel> packageTagData = [XtTagModel(tag: 'tag')];
    final orderInformationText = '5 ĐH | 12,8 km | ';
    final suggestSalaryText = '+ 53,424 đ';
    final isCtvXteam = true;
    final ctvCouponCoefficientRatio = 2.1;
    final isShowCoupon = ctvCouponCoefficientRatio > 1;
    final couponText = 'x 1.5';
    final String? address = 'Số 30 Miếu Đầm, Mễ Trì, Từ Liêm, Hà Nội';
    final String? distanceText = 'Cách 0,0 km | Dự kiến xuất: 10:24';
    final String? lastestImportText = '';

    //* Components
    final textButtonStyle = TextButton.styleFrom(
      textStyle: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      foregroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
    final disableTextButtonStyle = TextButton.styleFrom(
      textStyle: textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      foregroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
    final informationTextButtonStyle = TextButton.styleFrom(
      overlayColor: Colors.grey,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );

    final textStyle = textTheme.bodyMedium;
    final whiteTextStyle = textTheme.bodyMedium?.copyWith(
      color: Colors.white,
    );
    final ecomTextStyle = textTheme.bodyMedium?.copyWith(
      color: Colors.green,
    );
    final ecomBoldTextStyle = ecomTextStyle?.copyWith(
      color: Colors.green,
      fontWeight: FontWeight.w600,
    );
    final redTextStyle = textTheme.bodyMedium?.copyWith(
      color: Colors.red,
    );
    final boldTextStyle = textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
    );
    final titleTextStyle = textTheme.titleMedium;
    final blueTitleTextStyle = textTheme.titleMedium?.copyWith(
      color: Colors.blue,
    );
    final GlobalKey<TooltipState> _tooltipKey = GlobalKey<TooltipState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XtCommonRowType6(
          padding: const EdgeInsets.fromLTRB(10, 4, 8, 0),
          useDefaultAccessoryView: true,
          onTap: widget.selectAction,
          textLabel: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text.rich(
                  TextSpan(
                    style: textStyle?.copyWith(fontSize: 15),
                    children: [
                      TextSpan(
                        text: 'XUẤT',
                        style: blueTitleTextStyle,
                      ),
                      if (stationName.isValuable)
                        TextSpan(
                          text: ' | $stationName',
                          style: titleTextStyle,
                        ),
                      if (computedCoordinateDistanceText.isValuable)
                        TextSpan(
                          text: ' | $computedCoordinateDistanceText',
                          style: titleTextStyle,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          detailTextLabel: XtTagRow(
            data: packageTagData,
          ),
        ),
        XtCommonRowType6(
          textLabel: [
            Flexible(
              child: Text.rich(
                TextSpan(
                  style: textStyle?.copyWith(fontSize: 15),
                  children: [
                    if (orderInformationText.isValuable)
                      TextSpan(
                        text: orderInformationText,
                        style: boldTextStyle,
                      ),
                    if (suggestSalaryText.isValuable)
                      TextSpan(
                        text: suggestSalaryText,
                        style: ecomBoldTextStyle,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 30,
              height: 30,
              child: Tooltip(
                key: _tooltipKey,
                message: 'Đây là lương dự kiến nếu bạn chạy đủ km và giao 100% thành công có tích xanh',
                child: const Icon(
                  Icons.info_outline,
                  size: 14.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
          detailTextLabel: (isCtvXteam && isShowCoupon)
              ? SizedBox(
                  height: 20,
                  child: XtColorTag(
                    borderRadius: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(couponText, style: whiteTextStyle),
                  ),
                )
              : null,
        ),
        XtCommonRowType6(
          crossAxisAlignment: CrossAxisAlignment.start,
          textLabel: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (address.isValuable)
                    Text(
                      address!,
                      style: boldTextStyle,
                    ),
                  if (distanceText.isValuable)
                    Text(
                      distanceText!,
                      style: redTextStyle,
                    ),
                  if (lastestImportText.isValuable) Text(lastestImportText!),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        OrderActionBar(
          children: [
            Expanded(
              child: TextButton(
                style: textButtonStyle,
                onPressed: () {},
                child: const Text('Nhận đơn'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _toolTipAction() {}
}
