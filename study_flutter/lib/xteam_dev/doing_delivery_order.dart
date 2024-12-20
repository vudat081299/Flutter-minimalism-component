import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter/xteam_dev/components/doing_action_bar.dart';
import 'package:study_flutter/xteam_dev/components/rectangle_icon_button.dart';
import 'package:study_flutter/xteam_dev/components/string_extension.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row_type_3.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row_type_6.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_grid.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_model.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_row.dart';
import 'package:study_flutter/xteam_dev/doing_delivery_point_action_row.dart';

abstract class DoingDeliveryOrderData {
  String get alias;
  String get distance;
  bool get isShowReportKm;
  int get isXFast;
  bool get isPackageConnection;
  bool get isXfast2h;
  String get brandTag;
  bool get isShowHvcvip;
  bool get needDeliverOnTime;
  bool get requireToDelivery; // Yêu cầu đến điểm
  int get paymentWalletMoney;
  String
      get customer; // "\(data.name ?? "") | \(data.tel?.hidePhoneNumber() ?? "")"
  String? get customerColor;
  String? get pickAddress;
  String? get deliveryAddress;
  int? get pickMoney;
  int get couponPickMoney;
  List<String> get productNames;
  String? get imageUrl;
  bool get isShowCheckCustomer;
}

class DoingDeliveryOrderModel implements DoingDeliveryOrderData {
  @override
  String get alias => 'S525.XF2h.NTL2.2000080921';

  @override
  bool get isShowReportKm => true;

  @override
  String get distance => '10';

  @override
  int get isXFast => 1;
  @override
  bool get isPackageConnection => false;
  @override
  bool get isXfast2h => false;

  @override
  String get brandTag => 'Brand';

  @override
  bool get isShowHvcvip => true; //* !data.packageTypes.contains("hvc_vip") iOS

  @override
  bool get needDeliverOnTime => true;

  @override
  bool get requireToDelivery => true;

  @override
  int get paymentWalletMoney => 200000;

  @override
  String get customer => 'Tam test | 0989005019';

  @override
  String? get customerColor => '#FF9999';

  @override
  String? get pickAddress =>
      'số 8 Phạm Hùng, toà VTV Số 8 Phạm Hùng, Phạm Hùng, phường Mễ Trì, quận Từ Liêm, Hà Nội';

  @override
  String? get deliveryAddress =>
      'số 8 Pdfasdfas dsda fsd asd fs asd fas fas fasd ng, toà VTV Số 8 Phạm Hùng, Phạm Hùng, phường Mễ Trì, quận Từ Liêm, Hà Nội';

  @override
  int? get pickMoney => 10000;

  @override
  int get couponPickMoney => 10000;

  @override
  List<String> get productNames => ['quan', 'ao', 'giay'];

  @override
  String? get imageUrl => 'https://';

  @override
  bool get isShowCheckCustomer => true;
}

class DoingDeliveryOrder extends StatefulWidget {
  const DoingDeliveryOrder({
    super.key,
    required this.data,
    this.selectAction,
    this.completeAction,
    this.checkCustomerAction,
    this.chatAction,
    this.callAction,
    this.scanQRAction,
  });

  final DoingDeliveryOrderData data;
  final VoidCallback? selectAction;
  final VoidCallback? completeAction;
  final VoidCallback? checkCustomerAction;
  final VoidCallback? chatAction;
  final VoidCallback? callAction;
  final VoidCallback? scanQRAction;

  @override
  State<DoingDeliveryOrder> createState() => _DoingDeliveryOrderState();
}

class _DoingDeliveryOrderState extends State<DoingDeliveryOrder> {
  bool isShowMap = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final data = widget.data;
    final double selfWidth = MediaQuery.of(context).size.width;
    final double estimateMapHeight = selfWidth * 0.50;

    //* Prepare data
    bool isShowXFastTag = true;
    String xFastTag = '';
    if (data.isPackageConnection) {
      xFastTag = 'NỐI ĐIỂM';
    } else if (data.isXfast2h) {
      xFastTag = 'XFAST 2H';
    } else if (data.isXFast == 1) {
      xFastTag = 'XFAST';
    } else {
      isShowXFastTag = data.isXFast != 0;
    }

    final parts = data.alias.split('.');
    final labelMainText = parts.sublist(0, parts.length - 1).join('.');
    final labelLastPart = parts.last;
    final isShowReportKm = data.isShowReportKm;
    final reportKm = '${data.distance} km';
    final isShowBrand = data.brandTag.isNotEmpty;
    final isShowHvcvip = data.isShowHvcvip;
    final isShowDeliveryOnTime = data.needDeliverOnTime;
    final isShowRequireToDelivery = data.requireToDelivery;
    final isPaid = data.paymentWalletMoney > 0;
    final customerColor = data.customerColor;
    final pickMoney = data.pickMoney ?? 0;
    final couponPickMoney = data.couponPickMoney;
    final paymentWalletMoney = data.paymentWalletMoney;
    final collectMoney =
        'Tiền cần thu: ${max(0, pickMoney - couponPickMoney - paymentWalletMoney).toString().vndFormat()}';
    final product = ' | SP: ${data.productNames.join(', ')}';

    final imageUrl = data.imageUrl;

    //* Components
    final textButtonStyle = TextButton.styleFrom(
      textStyle: textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      foregroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XtCommonRowType6(
          padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
          useDefaultAccessoryView: true,
          onTap: () {},
          textLabel: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '$labelMainText.',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text: labelLastPart,
                        style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isShowReportKm)
                        const TextSpan(
                          text: ' / ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (isShowReportKm)
                        TextSpan(
                          text: reportKm,
                          style: const TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          detailTextLabel: XtTagRow(
            data: [
              XtTagModel(tag: 'Đơn gom'),
              if (isShowXFastTag)
                XtTagModel(tag: xFastTag, color: Colors.orange.shade300),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: XtTagGrid(
            data: [
              if (isShowBrand) XtTagModel(tag: data.brandTag),
              if (isShowHvcvip)
                XtTagModel(tag: 'HVC VIP', color: Colors.orange.shade300),
              if (isShowDeliveryOnTime)
                XtTagModel(
                    tag: 'Cần giao đúng hẹn', color: Colors.orange.shade300),
              if (isShowRequireToDelivery)
                XtTagModel(
                    tag: 'Yêu cầu đến điểm', color: Colors.orange.shade300),
            ],
          ),
        ),
        if (isPaid)
          const XtCommonRow(
            height: 26,
            children: [
              Icon(
                Icons.check,
                size: 16,
                color: Colors.green,
              ),
              SizedBox(width: 2),
              Text(
                'KH đã thanh toán',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        XtCommonRowType3(
          padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
          height: null,
          useDefaultAccessoryView: true,
          onTap: () {},
          textLabel: Row(
            children: [
              Text(data.customer),
              const SizedBox(width: 12),
              if (customerColor != null)
                Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: hexToColor(customerColor),
                    shape: BoxShape.circle,
                  ),
                ),
              const SizedBox(width: 4),
              SizedBox(
                width: 32,
                height: 32,
                child: RectangleIconButton(
                  onPressed: _viewMap,
                  icon: const Icon(
                    Icons.map,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        if (data.isXFast == 0 && data.pickAddress != null)
          DoingDeliveryPointActionRow(
            leftSide: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                            width: 3.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                    child: Container(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            rightSide: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: 'Lấy ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                    text: '${data.pickAddress}',
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ),
        if (data.isXFast == 0 && data.deliveryAddress != null)
          const SizedBox(height: 8),
        if (data.deliveryAddress != null)
          DoingDeliveryPointActionRow(
            leftSide: data.isXFast == 0
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: SizedBox(
                            width: 16,
                            height: 16,
                            child: Image.asset(
                              'point.png',
                              width: 16,
                              height: 16,
                              fit: BoxFit.contain,
                            )),
                      ),
                    ],
                  )
                : null,
            rightSide: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: 'Giao ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                    text: '${data.deliveryAddress}',
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ),
        const SizedBox(height: 4.0),
        XtCommonRowType6(
          crossAxisAlignment: CrossAxisAlignment.start,
          textLabel: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: collectMoney,
                            style: const TextStyle(
                              color: Colors.red,
                            )),
                        TextSpan(
                          text: product,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Chậm",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Ghi chú: ",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        "ĐH cần hẹn trước khi giao",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 24.0,
                        color: Colors.red,
                      )
                    ],
                  ),
                  Text(
                    'BC nhập kho: ',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
          detailTextLabel: (imageUrl != null && imageUrl.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      cacheKey: imageUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        'placeholder.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                )
              : null,
        ),
        if (isShowMap)
          // TODO: Add map here
          SizedBox(
            width: selfWidth,
            height: estimateMapHeight,
          ),
        const SizedBox(height: 4),
        DoingActionBar(
          children: [
            TextButton(
              style: textButtonStyle,
              onPressed: widget.completeAction,
              child: const Text('Hoàn thành'),
            ),
            Expanded(
              child: TextButton(
                style: textButtonStyle,
                onPressed: data.isShowCheckCustomer
                    ? widget.checkCustomerAction
                    : null,
                child: const Text('YCCK'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                height: 32,
                child: RectangleIconButton(
                  onPressed: widget.chatAction,
                  icon: const Icon(
                    Icons.chat,
                    size: 16,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                height: 32,
                child: RectangleIconButton(
                  onPressed: widget.callAction,
                  icon: const Icon(
                    Icons.call,
                    size: 16,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                height: 32,
                child: RectangleIconButton(
                  onPressed: widget.scanQRAction,
                  icon: const Icon(
                    Icons.qr_code_2,
                    size: 16,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (data.isShowCheckCustomer)
          ColoredBox(
            color: Colors.orange,
            child: SizedBox(width: selfWidth, height: 100),
          ),
      ],
    );
  }

  void _viewMap() {
    setState(() {
      isShowMap = !isShowMap;
    });
  }

  void _reportKm() {}

  Color hexToColor(String hex) {
    return Color(int.parse(hex.substring(1, 7), radix: 16) + 0xAA000000);
  }
}
