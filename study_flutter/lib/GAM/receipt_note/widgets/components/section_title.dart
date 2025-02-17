import 'package:flutter/material.dart';
import 'package:study_flutter/GAM/receipt_note/widgets/components/common_row.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.useDefaultAccessoryView = false,
  });
  
  final String title;
  final bool useDefaultAccessoryView;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonRow(
      height: 40,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        if (useDefaultAccessoryView)
          const Row(
            children: [
              SizedBox(width: 4.0),
              Icon(
                Icons.chevron_right,
                size: 24.0,
                color: Colors.black,
              ),
            ],
          ),
      ],
    );
  }
}
