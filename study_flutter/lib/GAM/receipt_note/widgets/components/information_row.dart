import 'package:flutter/material.dart';
import 'package:study_flutter/GAM/receipt_note/widgets/components/common_row_type_1.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({
    super.key,
    required this.label,
    required this.detailLabel,
  });

  final String label;
  final String detailLabel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.bodyMedium;
    return CommonRowType1(
      height: 26,
      textLabel: Text(
        label,
        style: textStyle,
      ),
      detailTextLabel: Text(
        detailLabel,
        style: textStyle?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
