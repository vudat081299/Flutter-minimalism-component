import 'package:flutter/material.dart';
import 'package:study_flutter/GAM/receipt_note/widgets/components/information_row.dart';
import 'package:study_flutter/GAM/receipt_note/widgets/components/section_title.dart';

class InfomrationSectionData {
  InfomrationSectionData({
    required this.needImport,
    required this.imported,
    required this.station,
    required this.creator,
    required this.status,
    required this.completedAt,
  });

  final String needImport;
  final String imported;
  final String station;
  final String creator;
  final String status;
  final String completedAt;
}

class InformationSection extends StatelessWidget {
  const InformationSection({
    super.key,
    required this.data,
  });

  final InfomrationSectionData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: 'Thông tin phiếu nhập'),
        const Divider(
          height: 0.5,
          thickness: 0.5,
          indent: 12,
          endIndent: 12,
        ),
        const SizedBox(height: 6),
        InformationRow(label: 'Cần nhập', detailLabel: data.needImport),
        InformationRow(label: 'Đã nhập', detailLabel: data.imported),
        InformationRow(label: 'Kho nhập', detailLabel: data.station),
        InformationRow(label: 'Người tạo phiếu', detailLabel: data.creator),
        InformationRow(label: 'Trạng thái', detailLabel: data.status),
        InformationRow(label: 'Thời gian hoàn thành', detailLabel: data.completedAt),
      ],
    );
  }
}
