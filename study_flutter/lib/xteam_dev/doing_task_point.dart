import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter/xteam_dev/components/date_extension.dart';
import 'package:study_flutter/xteam_dev/components/order_action_bar.dart';
import 'package:study_flutter/xteam_dev/components/point_xteam_type.dart';
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

abstract class DoingTaskPointData {
  int? get pointType;
  String? get alias;
  int? get isEndNode;
  String? get addressName;
  double? get distance;
  int? get countExportPackage;
  String get brandTag;
  List<String> get packageTypes;
  String? get shelfName;
  int get packageType;
  String? get name;
  String? get tel;
  int? get pickMoney;
  int? get countAllPackages;
  String? get shopName;
  String? get note;
  int get remainTime;
  String? get maxEstimateTime;
  String? get debtMoney;
  int get getTotalPrepay;
  List<String> get productNames;
  String? get imageUrl;
  int? get isAvailable; // is enable config button
}

class DoingTaskPointModel implements DoingTaskPointData {
  @override
  int? get pointType => 4;
  @override
  String? get alias => 'S100.HN01.20081929';
  @override
  int? get isEndNode => 0;
  @override
  String? get addressName =>
      'số 8 Phạm Hùng, toà VTV Số 8 Phạm Hùng, Phạm Hùng, phường Mễ Trì, quận Từ Liêm, Hà Nội';
  @override
  double? get distance => 3.3;
  @override
  int? get countExportPackage => 1;

  @override
  String get brandTag => 'Brand';

  @override
  List<String> get packageTypes => ['PKG', 'hvc_vip'];

  @override
  String? get shelfName => 'Shelf name';

  @override
  int get packageType => 1;

  @override
  String? get name => 'Thaoo thanh';

  @override
  String? get tel => '0899081299';

  @override
  int? get pickMoney => 200000;

  @override
  int? get countAllPackages => 6;

  @override
  String? get shopName => 'Top mart';

  @override
  String? get note => 'Fragile so dont shock package, keep far from heat';

  @override
  int get remainTime => 1200;

  @override
  String? get maxEstimateTime => '15:30';

  @override
  String? get debtMoney => '150000';

  @override
  int get getTotalPrepay => 100000;

  @override
  List<String> get productNames => ['Product 1', 'Product 2', 'Product 3'];

  @override
  String? get imageUrl => 'https://';

  @override
  int? get isAvailable => 1; // is enable config button
}

class DoingTaskPoint extends StatefulWidget {
  const DoingTaskPoint({
    super.key,
    required this.data,
    this.selectAction,
    this.configAction,
    this.checkCustomerAction,
    this.chatAction,
    this.callAction,
    this.scanQRAction,
  });

  final DoingTaskPointData data;
  final VoidCallback? selectAction;
  final VoidCallback? configAction;
  final VoidCallback? checkCustomerAction;
  final VoidCallback? chatAction;
  final VoidCallback? callAction;
  final VoidCallback? scanQRAction;

  @override
  State<DoingTaskPoint> createState() => _DoingTaskPointState();
}

class _DoingTaskPointState extends State<DoingTaskPoint> {
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
    Widget? label;
    final pointType = data.pointType;
    final type = PointXTeamType.fromRawValue(pointType);
    final alias = data.alias ?? '';
    final address = data.addressName ?? '';
    final countExportPackage = data.countExportPackage ?? 0;
    final distance = data.distance ?? 0.0;
    String? shelfName;
    final List<XtTagModel> tagsData = [];
    Widget? shipInformationLabel;
    final orderName = data.name ?? '';
    final orderTel = data.tel ?? '';
    String? userInformationText;
    final pickMoney = (data.pickMoney ?? 0).toString().vndFormat();
    final countAllPackages = data.countAllPackages;
    final note = data.note;
    final remainTime = XtPackageHelper.getRemainingTimeText(data.remainTime);
    final maxEstimateTime = data.maxEstimateTime;
    final debtMoney = data.debtMoney ?? '';
    final getTotalPrepay = data.getTotalPrepay;
    final productNames = data.productNames.join(', ');
    final collectMoney =
        (getTotalPrepay + debtMoney.toIntOrZero).toString().vndFormat();
    Widget? productWidget;
    String? shopNameText;
    String? noteText;
    String? timeText;
    Widget? collectMoneyWidget;
    final imageUrl = data.imageUrl;
    final iconButtonActions = [
      (widget.chatAction, Icons.chat, true),
      (_showMapAction, Icons.map, true),
    ];

    //* Components
    final textStyle = textTheme.bodyMedium;
    final labelTextStyle = textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
    );
    final enableActionButtonStyle = TextButton.styleFrom(
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

    if (type != null) {
      //* Label
      switch (type) {
        case PointXTeamType.importStation:
          final isEndNode = data.isEndNode == 0;
          String labelText = 'Nhập';
          if (isEndNode) {
            labelText = 'BC chốt phiên';
          }
          label = RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: labelText,
                  style: labelTextStyle?.copyWith(
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: ' | $address',
                  style: labelTextStyle,
                ),
              ],
            ),
          );
        case PointXTeamType.pick:
          label = RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'LẤY',
                  style: labelTextStyle?.copyWith(
                    color: Colors.orange,
                  ),
                ),
                TextSpan(
                  text: ' | $address',
                  style: labelTextStyle,
                ),
              ],
            ),
          );
        case PointXTeamType.deliver:
        case PointXTeamType.selfDeliver:
          label = Text(
            alias,
            style: labelTextStyle,
          );
        case PointXTeamType.returnItem:
          label = RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'TRẢ',
                  style: labelTextStyle?.copyWith(
                    color: '#854F9A'.hexColor,
                  ),
                ),
                TextSpan(
                  text: ' | $address',
                  style: labelTextStyle,
                ),
              ],
            ),
          );
        case PointXTeamType.exportStation:
          label = Text(
            'Xuất / $countExportPackage ĐH / $distance km',
            style: labelTextStyle,
          );
        default:
          break;
      }

      //* Shelf
      if (type == PointXTeamType.exportStation) {
        shelfName = data.shelfName;
      }

      //* Tags
      if (data.brandTag.isNotEmpty) {
        tagsData.add(XtTagModel(tag: data.brandTag));
      }
      final isShowHvcvip = data.packageTypes.contains("hvc_vip");
      if (isShowHvcvip) {
        tagsData.add(XtTagModel(tag: 'HVC VIP', color: Colors.orange.shade300));
      }
      switch (type) {
        case PointXTeamType.deliver:
        case PointXTeamType.selfDeliver:
        case PointXTeamType.exportStation:
          switch (data.packageType) {
            case 1:
              tagsData
                  .add(XtTagModel(tag: 'Dễ vỡ', color: Colors.red.shade400));
            case 2:
              tagsData.add(
                  XtTagModel(tag: 'Nông sản', color: Colors.orange.shade300));
            case 3:
              tagsData
                  .add(XtTagModel(tag: 'BBS', color: Colors.orange.shade300));
          }
        default:
      }

      //* Ship information
      switch (type) {
        case PointXTeamType.importStation:
        case PointXTeamType.postOfficeConfirmSession:
          if (orderName.isEmpty) break;
          shipInformationLabel = Text(orderName);
        case PointXTeamType.returnItem:
          if (orderName.isEmpty && orderTel.isEmpty) break;
          shipInformationLabel = Text('$orderName | $orderTel');
        case PointXTeamType.deliver:
        case PointXTeamType.selfDeliver:
          if (address.isEmpty) break;
          shipInformationLabel = DoingDeliveryPointActionRow(
            leftSide: Column(
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
            ),
            rightSide: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Giao ',
                    style: labelTextStyle,
                  ),
                  TextSpan(
                    text: address,
                    style: textStyle,
                  ),
                ],
              ),
            ),
            onPressed: () {},
          );
        case PointXTeamType.exportStation:
          if (address.isEmpty) break;
          shipInformationLabel = Text(
            address,
            style: labelTextStyle?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          );
        default:
          break;
      }

      //* User information
      switch (type) {
        case PointXTeamType.deliver:
        case PointXTeamType.selfDeliver:
        case PointXTeamType.pick:
          if (orderName.isEmpty && orderTel.isEmpty) break;
          userInformationText = '$orderName | $orderTel';
        default:
          break;
      }

      //* Collect money
      switch (type) {
        case PointXTeamType.deliver:
        case PointXTeamType.selfDeliver:
          productWidget = Text(
            'Tiền CoD: $pickMoney | SP: $productNames',
          );
          if (note != null) noteText = 'Ghi chú: $note';
        case PointXTeamType.pick:
          productWidget = Text(
            'Lấy $countAllPackages ĐH',
          );
          collectMoneyWidget = RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Tiền cần thu: ',
                  style: textStyle,
                ),
                TextSpan(
                  text: collectMoney,
                  style: textStyle?.copyWith(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        case PointXTeamType.returnItem:
          productWidget = Text('$countAllPackages ĐH');
        default:
          break;
      }

      //* Time
      if (type == PointXTeamType.exportStation) {
        timeText = remainTime;
      } else {
        timeText = '$remainTime | $distance km';
      }
      if (maxEstimateTime != null) {
        timeText += ' | Trước $maxEstimateTime';
      }

      //* Shop name
      if (type == PointXTeamType.deliver ||
          type == PointXTeamType.selfDeliver) {
        shopNameText = 'Shop: ${data.shopName ?? ''}';
      }
    }

    //* Actions bar
    final isAvailable = data.isAvailable == 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XtCommonRowType6(
          padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
          useDefaultAccessoryView: true,
          onTap: () {},
          textLabel: [
            if (label != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: label,
                ),
              ),
          ],
          detailTextLabel: XtTagRow(
            data: [
              if (shelfName != null)
                XtTagModel(tag: shelfName, color: Colors.orange.shade300),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: XtTagGrid(
            data: tagsData,
          ),
        ),
        if (shipInformationLabel != null) SizedBox(height: tagsData.isEmpty ? 2 : 8),
        if (shipInformationLabel != null) shipInformationLabel,
        const SizedBox(height: 2),
        XtCommonRowType3(
          padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
          height: null,
          textLabel: Row(
            children: [
              if (userInformationText != null) Text(userInformationText),
              const SizedBox(width: 4),
              SizedBox(
                width: 32,
                height: 32,
                child: RectangleIconButton(
                  onPressed: _callAction,
                  icon: const Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        XtCommonRowType6(
          crossAxisAlignment: CrossAxisAlignment.start,
          textLabel: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (productWidget != null) productWidget,
                  if (shopNameText != null)
                    Text(
                      shopNameText,
                      style: textStyle,
                    ),
                  if (noteText != null)
                    Text(
                      noteText,
                      style: textStyle?.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  if (timeText != null)
                    Text(
                      timeText,
                      style: textStyle?.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  if (collectMoneyWidget != null) collectMoneyWidget,
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
        const SizedBox(height: 4),
        if (isShowMap)
          // TODO: Add map here
          SizedBox(
            width: selfWidth,
            height: estimateMapHeight,
          ),
        if (isShowMap) const SizedBox(height: 4),
        OrderActionBar(
          children: [
            Expanded(
              child: TextButton(
                style: isAvailable
                    ? enableActionButtonStyle
                    : disableTextButtonStyle,
                onPressed: widget.configAction,
                child: const Text('Thao tác'),
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

  void _showMapAction() {
    setState(() {
      isShowMap = !isShowMap;
    });
  }

  void _callAction() {}

  //* Build widgets
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
