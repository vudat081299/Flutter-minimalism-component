import 'package:flutter/material.dart';
import 'package:study_flutter/xteam_dev/components/order_action_bar.dart';
import 'package:study_flutter/xteam_dev/components/rectangle_icon_button.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row_type_3.dart';
import 'package:study_flutter/xteam_dev/components/xt_common_row_type_6.dart';
import 'package:study_flutter/xteam_dev/components/xt_package_helper.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_grid.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_model.dart';
import 'package:study_flutter/xteam_dev/components/xt_tag_row.dart';

abstract class DoingExportPackageData {
  int? get countExportPackage;
  int get countCcdc;
  double? get distance;
  bool get isShowReportKm;
  String get shelf;
  String get packageLabel;
  List<String> get packageTypes;
  bool get isShowTagCCDC;
  int get packageType;
  String? get stationName;
  String? get address;
  int get remainTime;
  String? get maxEstimateTime;
  bool get isAvailable; // is enable config button
}

class DoingExportPackageModel implements DoingExportPackageData {
  @override
  int? get countExportPackage => 2;

  @override
  int get countCcdc => 2;

  @override
  double? get distance => 12.1234;

  @override
  bool get isShowReportKm => true;

  @override
  String get shelf => 'Đơn gộp';

  @override
  String get packageLabel => 'package label';

  @override
  List<String> get packageTypes => ['hvc_vip'];

  @override
  bool get isShowTagCCDC => true;

  @override
  int get packageType => 1;

  @override
  String? get stationName => 'Hà Nội';

  @override
  int get remainTime => 1200;

  @override
  String? get maxEstimateTime => '15:30';

  @override
  String? get address =>
      'số 8 Phạm Hùng, toà VTV Số 8 Phạm Hùng, Phạm Hùng, phường Mễ Trì, quận Từ Liêm, Hà Nội';

  @override
  bool get isAvailable => true;
}

class DoingExportPackage extends StatefulWidget {
  const DoingExportPackage({
    super.key,
    required this.data,
    this.selectAction,
    this.configAction,
  });

  final DoingExportPackageData data;
  final VoidCallback? selectAction;
  final VoidCallback? configAction;

  @override
  State<DoingExportPackage> createState() => _DoingExportPackageState();
}

class _DoingExportPackageState extends State<DoingExportPackage> {
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

    //* Components
    final baseTextStyle = textTheme.bodyMedium;
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
    final disableActionButtonStyle = TextButton.styleFrom(
      textStyle: textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      foregroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );

    //* Prepare data
    // Label
    final packageCount = data.countExportPackage ?? 0;
    final ccdcCount = data.countCcdc;
    final distance = data.distance ?? 0;
    final label = RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'XUẤT',
            style: labelTextStyle?.copyWith(
              color: Colors.blue,
            ),
          ),
          if (packageCount > 0)
            TextSpan(
              text: ' | $packageCount ĐH',
              style: labelTextStyle,
            ),
          if (ccdcCount > 0)
            TextSpan(
              text: ' ${packageCount > 0 ? '+' : '|'} $ccdcCount CCDC',
              style: labelTextStyle,
            ),
          if (data.isShowReportKm)
            TextSpan(
              text: ' | ',
              style: labelTextStyle,
            ),
          if (data.isShowReportKm)
            TextSpan(
              text: '${distance.toStringAsFixed(2)} km',
              style: labelTextStyle?.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
        ],
      ),
    );
    final shelf = data.shelf;
    final packageLabel = data.packageLabel;

    // Tags
    final List<XtTagModel> tagsData = [];
    final isShowHvcvip = data.packageTypes.contains("hvc_vip");
    if (isShowHvcvip) {
      tagsData.add(XtTagModel(
          tag: 'hvc vip'.toUpperCase(), color: Colors.orange.shade300));
    }
    if (data.isShowTagCCDC) {
      tagsData.add(
          XtTagModel(tag: 'Công cụ dụng cụ', color: Colors.orange.shade300));
    }
    switch (data.packageType) {
      case 1:
        tagsData.add(XtTagModel(tag: 'Dễ vỡ', color: Colors.red.shade400));
        break;
      case 2:
        tagsData
            .add(XtTagModel(tag: 'Nông sản', color: Colors.orange.shade300));
        break;
      case 3:
        tagsData.add(XtTagModel(tag: 'BBS', color: Colors.orange.shade300));
        break;
      default:
        break;
    }

    final stationName = data.stationName;
    final address = data.address;
    final remainTime = XtPackageHelper.getRemainingTimeText(data.remainTime);
    final maxEstimateTime = data.maxEstimateTime;
    final timeText =
        '$remainTime${((maxEstimateTime != null) ? ' | Trước $maxEstimateTime' : '')}';
    final isAvailable = data.isAvailable;

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
                child: label,
              ),
            ),
          ],
          detailTextLabel: XtTagRow(
            data: [
              if (shelf.isNotEmpty)
                XtTagModel(tag: shelf, color: Colors.orange.shade300),
            ],
          ),
        ),
        if (packageLabel.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              packageLabel,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (packageLabel.isNotEmpty) const SizedBox(height: 4.0),
        if (tagsData.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: XtTagGrid(
              data: tagsData,
            ),
          ),
        if (tagsData.isNotEmpty) const SizedBox(height: 4.0),
        XtCommonRowType3(
          padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
          height: null,
          textLabel: Row(
            children: [
              if (stationName != null) Text(stationName),
              const SizedBox(width: 4),
              SizedBox(
                width: 32,
                height: 32,
                child: RectangleIconButton(
                  onPressed: _showMapAction,
                  icon: const Icon(
                    Icons.map,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        XtCommonRowType6(
          crossAxisAlignment: CrossAxisAlignment.start,
          textLabel: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (address != null)
                    Text(
                      address,
                      style: baseTextStyle,
                    ),
                  Text(
                    timeText,
                    style: baseTextStyle?.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                    : disableActionButtonStyle,
                onPressed: widget.configAction,
                child: const Text('Thao tác'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //* Mini tasks

  void _showMapAction() {
    setState(() {
      isShowMap = !isShowMap;
    });
  }
}
