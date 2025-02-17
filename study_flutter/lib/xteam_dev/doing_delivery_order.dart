import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter/xteam_dev/components/date_extension.dart';
import 'package:study_flutter/xteam_dev/components/order_action_bar.dart';
import 'package:study_flutter/xteam_dev/components/rectangle_icon_button.dart';
import 'package:study_flutter/xteam_dev/components/string_extension.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row_type_3.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row_type_6.dart';
import 'package:study_flutter/xteam_dev/components/xt_package_helper.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_grid.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_model.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_row.dart';
import 'package:study_flutter/xteam_dev/doing_delivery_point_action_row.dart';

abstract class DoingDeliveryOrderData {
  String get alias;
  String get distance;
  bool get isShowReportKm;
  bool get isPackageCollection;
  int get isXFast;
  bool get isPackageConnection;
  bool get isXfast2h;
  String get packageLabel;
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
  String get dateToDelayDeliver;
  bool get isSlow;
  int? get remainTime;
  String? get maxEstimateTime; // Giao trước thời điểm này
  String? get note;
  String get deliverSession; // Hẹn giao
  String get importStation;
  String? get imageUrl;
  int? get isAvailable; // is enable complete button
  bool get isShowCheckCustomer;
  bool get isShowQrAction;
}

class DoingDeliveryOrderModel implements DoingDeliveryOrderData {
  @override
  String get alias => 'S525.XF2h.NTL2.2000080921';

  @override
  bool get isShowReportKm => true;

  @override
  String get distance => '10';

  @override
  bool get isPackageCollection => true;

  @override
  int get isXFast => 0;
  @override
  bool get isPackageConnection => false;
  @override
  bool get isXfast2h => false;

  @override
  String get packageLabel => 'Thực phẩm tươi khô'; // Tag thực phẩm tươi/khô...

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
  List<String> get productNames =>
      ['quan', 'ao', 'giay thep gai', 'giap cai', 'khien bang raduain'];

  @override
  String get dateToDelayDeliver => '14:00';

  @override
  bool get isSlow => true;

  @override
  int? get remainTime => 1200;

  @override
  String? get maxEstimateTime => '08:00';

  @override
  String? get note => 'Không để hàng hoá bị ướt';

  @override
  String get deliverSession => '2024-12-25 10:10:10';

  @override
  String get importStation => 'Tân phú trung';

  @override
  String? get imageUrl => 'https://';

  @override
  int? get isAvailable => 1;

  @override
  bool get isShowCheckCustomer => true;

  @override
  bool get isShowQrAction => true;
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
    bool isShowPackageForwardingTag = data.isPackageCollection;
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
    final packageLabel = data.packageLabel;
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

    //* Dự kiến giao
    String? estimatedDeliveryTime;
    final dateToDelayDeliver = data.dateToDelayDeliver;
    if (dateToDelayDeliver.isNotEmpty) {
      estimatedDeliveryTime = dateToDelayDeliver;
    }

    //* Slow order
    String slowStr = '';
    if (data.isSlow) {
      slowStr = 'Chậm';
    }
    final remain = data.remainTime;
    if (remain != null) {
      final timeStr = XtPackageHelper.getRemainingTimeText(remain);
      if (slowStr.isNotEmpty) {
        slowStr += ' | ';
      }
      slowStr += timeStr;
    }
    final maxAppointmentTime = data.maxEstimateTime;
    if (maxAppointmentTime != null && maxAppointmentTime.isNotEmpty) {
      if (slowStr.isNotEmpty) {
        slowStr += ' | ';
      }
      slowStr += 'Trước $maxAppointmentTime';
    }

    //* Note
    String? noteText;
    final note = data.note;
    if (note != null && note.isNotEmpty) {
      noteText = 'Ghi chú: $note';
    }

    final isDeliveryScheduleAvailable = data.deliverSession.isNotEmpty;
    String deliverySchedule;
    if (isDeliveryScheduleAvailable) {
      deliverySchedule =
          'Hẹn giao: ${data.deliverSession.toDate('yyyy-MM-dd HH:mm:ss').text('HH\'h\'mm dd/MM')}';
    } else {
      deliverySchedule = 'ĐH cần hẹn trước khi giao';
    }

    //* Import station
    String? importStationText;
    final importStation = data.importStation;
    if (importStation.isNotEmpty) {
      importStationText = importStation;
    }

    //* Image
    final imageUrl = data.imageUrl;

    //* Action bar
    final isAvailable = data.isAvailable == 1;
    final isShowCheckCustomer = data.isShowCheckCustomer;
    final isShowQrAction = data.isShowQrAction;
    final iconButtonActions = [
      (widget.chatAction, Icons.chat, true),
      (widget.callAction, Icons.call, true),
      (widget.scanQRAction, Icons.qr_code_2, isShowQrAction),
    ];

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
    final disableTextButtonStyle = TextButton.styleFrom(
      textStyle: textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      foregroundColor: Colors.grey,
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
                            backgroundColor: Colors.orange,
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
              if (isShowPackageForwardingTag) XtTagModel(tag: 'Đơn gom'),
              if (isShowXFastTag)
                XtTagModel(tag: xFastTag, color: Colors.orange.shade300),
            ],
          ),
        ),
        if (packageLabel.isNotEmpty)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  packageLabel,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4.0),
            ],
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
                      color: Colors.grey.shade300,
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
                  if (estimatedDeliveryTime != null)
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Dự kiến giao: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(
                            text: estimatedDeliveryTime,
                          ),
                        ],
                      ),
                    ),
                  if (slowStr.isNotEmpty)
                    Text(
                      slowStr,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (noteText != null)
                    Text(
                      noteText,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (data.isXFast == 1)
                    Row(
                      children: [
                        Text(
                          deliverySchedule,
                          style: TextStyle(
                            color: isDeliveryScheduleAvailable
                                ? Colors.black
                                : Colors.red,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (!isDeliveryScheduleAvailable)
                          Row(
                            children: [
                              const SizedBox(width: 4.0),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    size: 24.0,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                      ],
                    ),
                  if (importStationText != null)
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: 'BC nhập kho: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(
                            text: importStationText,
                          ),
                        ],
                      ),
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
        const SizedBox(height: 4.0),
        if (isShowMap)
          // TODO: Add map here
          SizedBox(
            width: selfWidth,
            height: estimateMapHeight,
          ),
        const SizedBox(height: 4),
        OrderActionBar(
          children: [
            TextButton(
              style: isAvailable ? textButtonStyle : disableTextButtonStyle,
              onPressed: widget.completeAction,
              child: const Text('Hoàn thành'),
            ),
            Expanded(
              child: TextButton(
                style: textButtonStyle,
                onPressed:
                    isShowCheckCustomer ? widget.checkCustomerAction : null,
                child: const Text('YCCK'),
              ),
            ),
            ..._buildActionBarIconButtons(iconButtonActions),
          ],
        ),
      ],
    );
  }

  //* Mini tasks
  Color hexToColor(String hex) {
    return Color(int.parse(hex.substring(1, 7), radix: 16) + 0xAA000000);
  }

  void _viewMap() {
    setState(() {
      isShowMap = !isShowMap;
    });
  }

  List<Widget> _buildActionBarIconButtons(
      List<(void Function()?, IconData, bool)> data) {
    return data
        .where((item) => item.$3)
        .map((item) => _buildActionBarIconButton(item))
        .toList();
  }

  Widget _buildActionBarIconButton((void Function()?, IconData, bool) item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        height: 32,
        child: RectangleIconButton(
          onPressed: item.$1,
          icon: Icon(
            item.$2,
            size: 16,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
