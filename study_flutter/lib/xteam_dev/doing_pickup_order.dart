import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter/xteam_dev/components/order_action_bar.dart';
import 'package:study_flutter/xteam_dev/components/rectangle_icon_button.dart';
import 'package:study_flutter/xteam_dev/components/xt_color_tag.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row_type_6.dart';
import 'package:study_flutter/xteam_dev/components/xt_package_helper.dart';

abstract class DoingPickupOrderData {
  List<int> get countPackages;

  String? get shopCode;
  String get distance;
  String get brandTag;
  String
      get shop; // "\(data.name ?? "") / \(data.tel?.hidePhoneNumber() ?? "")" iOS
  String get address;
  String? get intentPickupTime;
  String? get imageUrl;

  int get isXFast;
  int? get collectMoney; // data.getTotalPrepay() + data.shopDebtBill
  int? get remainTime;

  bool get isShowReportKm;
  bool get isPackageConnection;
  bool get isXfast2h;
  bool get isShowHvcvip; // packageTypes.contains("hvc_vip") iOS
  bool get isShowBrand;
  bool get noCallShop;
  bool get isSlow;
  bool get isShowCheckShop;
  bool get isEnableCreatePackage;
}

class DoingPickupOrderModel implements DoingPickupOrderData {
  @override
  String get shopCode => 'S123.hcc.HN20';
  @override
  List<int> get countPackages => [1, 2, 3];
  @override
  bool get isShowReportKm => true;
  @override
  String get distance => '10';

  @override
  bool get isPackageConnection => true;

  @override
  bool get isXfast2h => true;

  @override
  bool get isSlow => true;

  @override
  int get isXFast => 1;

  @override
  bool get noCallShop => false;

  @override
  bool get isShowBrand => true;

  @override
  bool get isShowHvcvip => true;

  @override
  String get brandTag => 'Zarrr';

  @override
  String get shop => 'lim | 098***5669';

  @override
  String get address =>
      'Keangnam Landmark, Keangnam Landmark, phường Mễ trì, Quận Từ Liêm, Hà Nội';

  @override
  int? get collectMoney => 0;

  @override
  String get intentPickupTime => '08:00';

  @override
  int get remainTime => 1200;

  @override
  String get imageUrl => 'https://';

  @override
  bool get isShowCheckShop => true;

  @override
  bool get isEnableCreatePackage => true;
}

class DoingPickupOrder extends StatefulWidget {
  const DoingPickupOrder({
    super.key,
    required this.data,
    this.selectAction,
    this.completeAction,
    this.checkShopAction,
    this.createOrderAction,
    this.chatAction,
    this.callAction,
  });

  final DoingPickupOrderData data;
  final VoidCallback? selectAction;
  final VoidCallback? completeAction;
  final VoidCallback? checkShopAction;
  final VoidCallback? createOrderAction;
  final VoidCallback? chatAction;
  final VoidCallback? callAction;

  @override
  State<DoingPickupOrder> createState() => _DoingPickupOrderState();
}

class _DoingPickupOrderState extends State<DoingPickupOrder> {
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
    final isShowHvcvip = data.isShowHvcvip;
    final isShowBrand = data.isShowBrand;
    final isShowCheckShop = data.isShowCheckShop;
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

    final shopCode = data.shopCode != null ? '${data.shopCode} | ' : '';
    final isShowReportKm = data.isShowReportKm;
    final String label =
        'Lấy | $shopCode${data.countPackages.length} ĐH${isShowReportKm ? ' /' : ''}';
    final reportKm = '${data.distance} km';
    final collectMoney = data.collectMoney;
    final intentPickupTime = data.intentPickupTime;
    final imageUrl = data.imageUrl;

    String? slowStr;
    if (data.isSlow) {
      slowStr = 'Chậm';
    }
    final overtime = data.remainTime;
    if (overtime != null) {
      final timeStr = XtPackageHelper.getRemainingTimeText(overtime);
      if (slowStr != null && slowStr.isNotEmpty) {
        slowStr += ' | ';
      }
      slowStr = '$slowStr$timeStr';
    }

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
      children: [
        XtCommonRowType6(
          padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
          useDefaultAccessoryView: true,
          onTap: () {},
          textLabel: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (isShowReportKm)
              TextButton(
                onPressed: _reportKm,
                style: TextButton.styleFrom(
                  textStyle: textTheme.labelMedium,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  reportKm,
                  style: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
          ],
          detailTextLabel: isShowXFastTag
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: XtColorTag(
                      color: Colors.orange.shade300,
                      child: Text(
                        xFastTag.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        ),
        XtCommonRow(
          height: 26,
          children: [
            if (isShowHvcvip)
              Row(
                children: [
                  XtColorTag(
                    color: Colors.orange.shade300,
                    child: Text(
                      'HVC VIP'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            if (isShowBrand)
              XtColorTag(
                color: Colors.green,
                child: Text(
                  data.brandTag.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {},
              ),
          ],
        ),
        XtCommonRow(
          height: null,
          children: [
            Text(data.shop),
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
        XtCommonRow(
          height: null,
          children: [
            Expanded(
              child: Text(
                data.address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        XtCommonRowType6(
          crossAxisAlignment: CrossAxisAlignment.start,
          textLabel: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (collectMoney != null && collectMoney > 0)
                    Text(
                      'Tiền cần thu: $collectMoney',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (intentPickupTime != null)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Dự kiến lấy: $intentPickupTime',
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  if (slowStr != null)
                    Text(
                      slowStr,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
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
        OrderActionBar(
          children: [
            TextButton(
              style: textButtonStyle,
              onPressed: widget.completeAction,
              child: const Text('Hoàn thành'),
            ),
            if (isShowCheckShop)
              Expanded(
                child: TextButton(
                  style: textButtonStyle,
                  onPressed: widget.checkShopAction,
                  child: const Text('YCCS'),
                ),
              ),
            if (data.isEnableCreatePackage)
              Expanded(
                child: TextButton(
                  style: textButtonStyle,
                  onPressed: widget.createOrderAction,
                  child: const Text('Tạo đơn'),
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
            if (!data.noCallShop)
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
          ],
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
}
